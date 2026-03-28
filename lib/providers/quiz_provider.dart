import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/question.dart';
import '../models/quiz_result.dart';
import '../data/question_bank.dart';

class QuizProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  String _selectedCategory = 'all';
  String _selectedSubcategory = 'all';
  int _questionCount = 10;
  int _timeLimitMinutes = 10;
  String _questionType = 'mixed';
  String _difficulty = 'mixed';

  List<String> _askedQuestionIds = [];

  List<Question> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>> _answeredQuestions = [];
  bool _isQuizActive = false;

  int _totalQuizzesTaken = 0;
  int _totalCorrect = 0;
  int _totalWrong = 0;
  List<QuizResult> _quizHistory = [];
  List<Question> _wrongQuestionPool = [];
  List<Question> _userQuestions = [];

  // Getters
  String get selectedCategory => _selectedCategory;
  String get selectedSubcategory => _selectedSubcategory;
  int get questionCount => _questionCount;
  int get timeLimitMinutes => _timeLimitMinutes;
  String get questionType => _questionType;
  String get difficulty => _difficulty;
  List<Question> get currentQuestions => _currentQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<Map<String, dynamic>> get answeredQuestions => _answeredQuestions;
  bool get isQuizActive => _isQuizActive;
  int get totalQuizzesTaken => _totalQuizzesTaken;
  int get totalCorrect => _totalCorrect;
  int get totalWrong => _totalWrong;
  List<QuizResult> get quizHistory => _quizHistory;
  List<Question> get wrongQuestionPool => _wrongQuestionPool;
  List<Question> get userQuestions => _userQuestions;

  int get correctAnswers => _answeredQuestions.where((a) => a['isCorrect'] == true).length;
  int get wrongAnswers => _answeredQuestions.where((a) => a['isCorrect'] == false).length;
  int get answeredCount => _answeredQuestions.length;
  int get unansweredCount => _currentQuestions.length - _answeredQuestions.length;

  Question? get currentQuestion =>
      _currentQuestionIndex < _currentQuestions.length ? _currentQuestions[_currentQuestionIndex] : null;

  double get progressPercentage =>
      _currentQuestions.isEmpty ? 0 : (_currentQuestionIndex / _currentQuestions.length);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadStats();
    _loadWrongQuestions();
    _loadUserQuestions();
    _loadAskedQuestionIds();
  }

  // ============================================================
  // AYARLAR
  // ============================================================
  void setCategory(String category) { _selectedCategory = category; _selectedSubcategory = 'all'; notifyListeners(); }
  void setSubcategory(String subcategory) { _selectedSubcategory = subcategory; notifyListeners(); }
  void setQuestionCount(int count) { _questionCount = count; notifyListeners(); }
  void setTimeLimit(int minutes) { _timeLimitMinutes = minutes; notifyListeners(); }
  void setQuestionType(String type) { _questionType = type; notifyListeners(); }
  void setDifficulty(String diff) { _difficulty = diff; notifyListeners(); }

  // ============================================================
  // QUIZ BAŞLAT
  // ============================================================
  void startQuiz({bool fromWrongPool = false}) {
    List<Question> pool;

    if (fromWrongPool) {
      pool = List.from(_wrongQuestionPool);
      pool.shuffle();
      _currentQuestions = pool.take(_questionCount).toList();
    } else {
      pool = QuestionBank.getUniqueQuestions(
        count: _questionCount,
        category: _selectedCategory,
        subcategory: _selectedSubcategory,
        type: _questionType,
        difficulty: _difficulty,
        excludeIds: _askedQuestionIds,
      );

      if (pool.length < _questionCount) {
        _askedQuestionIds.clear();
        pool = QuestionBank.getUniqueQuestions(
          count: _questionCount,
          category: _selectedCategory,
          subcategory: _selectedSubcategory,
          type: _questionType,
          difficulty: _difficulty,
          excludeIds: [],
        );
      }

      if (_userQuestions.isNotEmpty) {
        var userFiltered = _userQuestions.where((q) {
          if (_selectedCategory != 'all' && q.category != _selectedCategory) return false;
          if (_selectedSubcategory != 'all' && q.subcategory != _selectedSubcategory) return false;
          if (_difficulty != 'mixed' && q.difficulty != _difficulty) return false;
          return true;
        }).toList();
        userFiltered.shuffle();
        pool.addAll(userFiltered.take(3));
      }

      pool.shuffle();
      _currentQuestions = pool.take(_questionCount).toList();

      for (var q in _currentQuestions) {
        if (!_askedQuestionIds.contains(q.id)) {
          _askedQuestionIds.add(q.id);
        }
      }
      _saveAskedQuestionIds();
    }

    _currentQuestionIndex = 0;
    _answeredQuestions = [];
    _isQuizActive = true;
    notifyListeners();
  }

  // ============================================================
  // SORU NAVİGASYONU
  // ============================================================
  void goToQuestion(int index) {
    if (index >= 0 && index < _currentQuestions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _currentQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Sonraki cevaplanmamış soruya git
  void skipToNextUnanswered() {
    // Önce mevcut indexten sonra cevaplanmamış ara
    for (int i = _currentQuestionIndex + 1; i < _currentQuestions.length; i++) {
      if (getAnswerForQuestion(i) == null) {
        _currentQuestionIndex = i;
        notifyListeners();
        return;
      }
    }
    // Baştan ara
    for (int i = 0; i < _currentQuestionIndex; i++) {
      if (getAnswerForQuestion(i) == null) {
        _currentQuestionIndex = i;
        notifyListeners();
        return;
      }
    }
    // Hepsi cevaplandıysa sonraki soruya git
    if (_currentQuestionIndex < _currentQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // ============================================================
  // CEVAP KONTROL
  // ============================================================
  String? getAnswerForQuestion(int index) {
    for (var ans in _answeredQuestions) {
      if (ans['questionIndex'] == index) {
        return ans['userAnswer'] as String;
      }
    }
    return null;
  }

  Map<String, dynamic>? getAnswerDataForQuestion(int index) {
    for (var ans in _answeredQuestions) {
      if (ans['questionIndex'] == index) {
        return ans;
      }
    }
    return null;
  }

  bool isQuestionAnswered(int index) {
    return getAnswerForQuestion(index) != null;
  }

  bool isQuestionCorrect(int index) {
    final data = getAnswerDataForQuestion(index);
    if (data == null) return false;
    return data['isCorrect'] as bool;
  }

  // ============================================================
  // CEVAP VER
  // ============================================================
  void answerQuestion(String userAnswer) {
    if (_currentQuestionIndex >= _currentQuestions.length) return;

    // Bu soruya daha önce cevap verilmiş mi kontrol et
    final existingIndex = _answeredQuestions.indexWhere((a) => a['questionIndex'] == _currentQuestionIndex);
    if (existingIndex != -1) return; // Zaten cevaplanmış

    final question = _currentQuestions[_currentQuestionIndex];
    final isCorrect = question.checkAnswer(userAnswer);

    _answeredQuestions.add({
      'questionIndex': _currentQuestionIndex,
      'question': question,
      'userAnswer': userAnswer,
      'isCorrect': isCorrect,
    });

    // Yanlış havuzunu güncelle
    if (isCorrect) {
      _wrongQuestionPool.removeWhere((q) => q.id == question.id);
    } else {
      if (!_wrongQuestionPool.any((q) => q.id == question.id)) {
        _wrongQuestionPool.add(question);
      }
    }

    notifyListeners();
  }

  // ============================================================
  // QUIZ BİTİR
  // ============================================================
  QuizResult finishQuiz() {
    _isQuizActive = false;

    // Cevaplanmamış soruları yanlış olarak ekle
    for (int i = 0; i < _currentQuestions.length; i++) {
      if (getAnswerForQuestion(i) == null) {
        _answeredQuestions.add({
          'questionIndex': i,
          'question': _currentQuestions[i],
          'userAnswer': '',
          'isCorrect': false,
          'isSkipped': true,
        });
        // Yanlış havuzuna ekle
        if (!_wrongQuestionPool.any((q) => q.id == _currentQuestions[i].id)) {
          _wrongQuestionPool.add(_currentQuestions[i]);
        }
      }
    }

    // Sırala
    final sortedAnswers = List<Map<String, dynamic>>.from(_answeredQuestions);
    sortedAnswers.sort((a, b) => (a['questionIndex'] as int).compareTo(b['questionIndex'] as int));

    int totalCorrect_ = sortedAnswers.where((a) => a['isCorrect'] == true).length;
    int totalWrong_ = sortedAnswers.where((a) => a['isCorrect'] == false).length;

    final result = QuizResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: _selectedCategory,
      totalQuestions: _currentQuestions.length,
      correctAnswers: totalCorrect_,
      wrongAnswers: totalWrong_,
      date: DateTime.now(),
      timeTaken: _timeLimitMinutes,
      answeredQuestions: sortedAnswers,
    );

    _quizHistory.insert(0, result);
    _totalQuizzesTaken++;
    _totalCorrect += totalCorrect_;
    _totalWrong += totalWrong_;

    _saveStats();
    _saveWrongQuestions();
    notifyListeners();
    return result;
  }

  // ============================================================
  // KULLANICI SORU
  // ============================================================
  void addUserQuestion(Question question) { _userQuestions.add(question); _saveUserQuestions(); notifyListeners(); }
  void removeUserQuestion(String questionId) { _userQuestions.removeWhere((q) => q.id == questionId); _saveUserQuestions(); notifyListeners(); }

  // ============================================================
  // VERİ KAYDETME / YÜKLEME
  // ============================================================
  void _saveStats() {
    _prefs.setInt('total_quizzes', _totalQuizzesTaken);
    _prefs.setInt('total_correct', _totalCorrect);
    _prefs.setInt('total_wrong', _totalWrong);
    List<String> historyJson = _quizHistory.take(50).map((r) => jsonEncode(r.toJson())).toList();
    _prefs.setStringList('quiz_history', historyJson);
  }

  void _loadStats() {
    _totalQuizzesTaken = _prefs.getInt('total_quizzes') ?? 0;
    _totalCorrect = _prefs.getInt('total_correct') ?? 0;
    _totalWrong = _prefs.getInt('total_wrong') ?? 0;
    List<String>? historyJson = _prefs.getStringList('quiz_history');
    if (historyJson != null) {
      _quizHistory = historyJson.map((s) => QuizResult.fromJson(jsonDecode(s))).toList();
    }
  }

  void _saveWrongQuestions() {
    List<String> wrongJson = _wrongQuestionPool.map((q) => jsonEncode(q.toJson())).toList();
    _prefs.setStringList('wrong_questions', wrongJson);
  }

  void _loadWrongQuestions() {
    List<String>? wrongJson = _prefs.getStringList('wrong_questions');
    if (wrongJson != null) {
      _wrongQuestionPool = wrongJson.map((s) => Question.fromJson(jsonDecode(s))).toList();
    }
  }

  void _saveUserQuestions() {
    List<String> userJson = _userQuestions.map((q) => jsonEncode(q.toJson())).toList();
    _prefs.setStringList('user_questions', userJson);
  }

  void _loadUserQuestions() {
    List<String>? userJson = _prefs.getStringList('user_questions');
    if (userJson != null) {
      _userQuestions = userJson.map((s) => Question.fromJson(jsonDecode(s))).toList();
    }
  }

  void _saveAskedQuestionIds() { _prefs.setStringList('asked_question_ids', _askedQuestionIds); }
  void _loadAskedQuestionIds() { _askedQuestionIds = _prefs.getStringList('asked_question_ids') ?? []; }

  void resetAskedQuestions() { _askedQuestionIds.clear(); _saveAskedQuestionIds(); notifyListeners(); }

  void resetStats() {
    _totalQuizzesTaken = 0; _totalCorrect = 0; _totalWrong = 0;
    _quizHistory.clear(); _wrongQuestionPool.clear(); _askedQuestionIds.clear();
    _saveStats(); _saveWrongQuestions(); _saveAskedQuestionIds();
    notifyListeners();
  }
}
