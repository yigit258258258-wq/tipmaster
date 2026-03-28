import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;
  String? _selectedOption;
  final TextEditingController _openAnswerController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    _remainingSeconds = quizProvider.timeLimitMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
    _timer?.cancel();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final result = quizProvider.finishQuiz();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ResultScreen(result: result)),
    );
  }

  void _submitAnswer(QuizProvider provider) {
    if (_isCurrentQuestionAnswered(provider)) return;

    String answer;
    if (provider.currentQuestion!.type == 'test') {
      if (_selectedOption == null) return;
      answer = _selectedOption!;
    } else {
      if (_openAnswerController.text.trim().isEmpty) return;
      answer = _openAnswerController.text.trim();
    }

    provider.answerQuestion(answer);
    setState(() {});
  }

  bool _isCurrentQuestionAnswered(QuizProvider provider) {
    return provider.isQuestionAnswered(provider.currentQuestionIndex);
  }

  void _skipQuestion(QuizProvider provider) {
    // Sadece sonraki cevaplanmamış soruya geç, cevap kaydetme
    provider.skipToNextUnanswered();
    _loadQuestionState(provider);
  }

  void _goToNextQuestion(QuizProvider provider) {
    if (provider.currentQuestionIndex < provider.currentQuestions.length - 1) {
      provider.nextQuestion();
      _loadQuestionState(provider);
    }
  }

  void _goToQuestion(QuizProvider provider, int index) {
    provider.goToQuestion(index);
    _loadQuestionState(provider);
    Navigator.pop(context); // Drawer kapat
  }

  void _loadQuestionState(QuizProvider provider) {
    setState(() {
      _selectedOption = null;
      _openAnswerController.clear();
    });

    // Bu soruya daha önce cevap verildiyse göster
    final existingAnswer = provider.getAnswerForQuestion(provider.currentQuestionIndex);
    if (existingAnswer != null) {
      setState(() {
        if (provider.currentQuestion?.type == 'test') {
          _selectedOption = existingAnswer;
        } else {
          _openAnswerController.text = existingAnswer;
        }
      });
    }
  }

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  bool _isLatinTermTheAnswer(Question question) {
    if (question.latinTerm == null) return false;
    final latin = question.latinTerm!.toLowerCase().trim();
    final answer = question.correctAnswer.toLowerCase().trim();
    return latin.contains(answer) || answer.contains(latin) || latin == answer;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _openAnswerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _showExitDialog();
      },
      child: Consumer<QuizProvider>(
        builder: (context, provider, child) {
          final question = provider.currentQuestion;
          if (question == null) return const SizedBox();
          final isAnswered = _isCurrentQuestionAnswered(provider);

          return Scaffold(
            key: _scaffoldKey,
            endDrawer: _buildQuestionDrawer(provider, theme, primary),
            body: SafeArea(
              child: Column(
                children: [
                  _buildTopBar(provider, theme, primary),
                  LinearProgressIndicator(
                    value: provider.answeredCount / provider.currentQuestions.length,
                    backgroundColor: theme.colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation(primary),
                    minHeight: 3,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildQuestionHeader(question, theme),
                          const SizedBox(height: 16),
                          if (question.hasImage) _buildImageWidget(question, theme),
                          const SizedBox(height: 16),
                          _buildQuestionText(question, theme),
                          const SizedBox(height: 8),

                          // Latince terim
                          if (question.latinTerm != null && !_isLatinTermTheAnswer(question))
                            _buildLatinTerm(question, theme)
                          else if (question.latinTerm != null && _isLatinTermTheAnswer(question) && isAnswered)
                            _buildLatinTerm(question, theme),

                          const SizedBox(height: 24),

                          if (question.type == 'test')
                            _buildTestOptions(question, theme, primary, isAnswered)
                          else
                            _buildOpenAnswer(theme, primary, isAnswered, provider),

                          const SizedBox(height: 24),
                          if (isAnswered) _buildExplanation(question, provider, theme),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomBar(provider, theme, primary, isAnswered),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // YAN MENÜ (DRAWER)
  // ============================================================
  Widget _buildQuestionDrawer(QuizProvider provider, ThemeData theme, Color primary) {
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(bottom: BorderSide(color: theme.dividerColor)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Soru Navigasyonu', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 4),
                  Text('${provider.answeredCount} / ${provider.currentQuestions.length} cevaplandı',
                      style: GoogleFonts.poppins(fontSize: 13, color: theme.colorScheme.onSurface.withOpacity(0.5))),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildLegendDot(Colors.greenAccent, 'Doğru'),
                      const SizedBox(width: 10),
                      _buildLegendDot(Colors.redAccent, 'Yanlış'),
                      const SizedBox(width: 10),
                      _buildLegendDot(primary, 'Mevcut'),
                      const SizedBox(width: 10),
                      _buildLegendDot(theme.cardColor, 'Boş'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8,
                  ),
                  itemCount: provider.currentQuestions.length,
                  itemBuilder: (context, index) {
                    final isCurrent = index == provider.currentQuestionIndex;
                    final isAnswered = provider.isQuestionAnswered(index);

                    Color bgColor, textColor, borderColor;

                    if (isCurrent) {
                      bgColor = primary; textColor = Colors.white; borderColor = primary;
                    } else if (isAnswered) {
                      final isCorrect = provider.isQuestionCorrect(index);
                      if (isCorrect) {
                        bgColor = Colors.greenAccent.withOpacity(0.15);
                        textColor = Colors.greenAccent;
                        borderColor = Colors.greenAccent.withOpacity(0.5);
                      } else {
                        bgColor = Colors.redAccent.withOpacity(0.15);
                        textColor = Colors.redAccent;
                        borderColor = Colors.redAccent.withOpacity(0.5);
                      }
                    } else {
                      bgColor = theme.cardColor;
                      textColor = theme.colorScheme.onSurface.withOpacity(0.6);
                      borderColor = theme.dividerColor;
                    }

                    return GestureDetector(
                      onTap: () => _goToQuestion(provider, index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: bgColor, borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: borderColor, width: isCurrent ? 2 : 1),
                        ),
                        child: Center(
                          child: Text('${index + 1}', style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500, color: textColor,
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Sınavı bitir butonu
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity, height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showFinishDialog(provider);
                  },
                  icon: const Icon(Icons.flag, color: Colors.white, size: 20),
                  label: Text('Sınavı Bitir', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  // ============================================================
  // GÖRSEL WİDGET (ASSETS'TEN YEREL GÖRSEL)
  // ============================================================
  Widget _buildImageWidget(Question question, ThemeData theme) {
    final primary = theme.colorScheme.primary;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primary.withOpacity(0.15)),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: Image.asset(
                question.imageUrl!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image_outlined, size: 40, color: theme.colorScheme.onSurface.withOpacity(0.3)),
                        const SizedBox(height: 8),
                        Text('Görsel yüklenemedi',
                            style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.4))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 8, left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.85),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image, size: 12, color: primary),
                  const SizedBox(width: 4),
                  Text('Görselli Soru', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: primary)),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  // ============================================================
  // ÜST BAR
  // ============================================================
  Widget _buildTopBar(QuizProvider provider, ThemeData theme, Color primary) {
    bool isLowTime = _remainingSeconds < 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(onPressed: _showExitDialog, icon: Icon(Icons.close, color: theme.colorScheme.onSurface.withOpacity(0.5), size: 22)),
          Expanded(
            child: Center(
              child: Text('${provider.currentQuestionIndex + 1} / ${provider.currentQuestions.length}',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isLowTime ? Colors.red.withOpacity(0.15) : theme.cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer_outlined, size: 16, color: isLowTime ? Colors.redAccent : primary),
                const SizedBox(width: 4),
                Text(_formatTime(_remainingSeconds), style: GoogleFonts.jetBrainsMono(
                  fontSize: 13, fontWeight: FontWeight.w600, color: isLowTime ? Colors.redAccent : theme.colorScheme.onSurface,
                )),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            icon: Icon(Icons.grid_view_rounded, color: primary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(Question question, ThemeData theme) {
    Color diffColor; String diffText;
    switch (question.difficulty) {
      case 'easy': diffColor = Colors.greenAccent; diffText = 'Kolay'; break;
      case 'medium': diffColor = Colors.orangeAccent; diffText = 'Orta'; break;
      case 'hard': diffColor = Colors.redAccent; diffText = 'Zor'; break;
      default: diffColor = Colors.blueAccent; diffText = '';
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: diffColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
          child: Text(diffText, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: diffColor)),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(question.type == 'test' ? 'Çoktan Seçmeli' : 'Açık Uçlu',
              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, color: theme.colorScheme.primary)),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildQuestionText(Question question, ThemeData theme) {
    return Text(question.questionText, style: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface, height: 1.5,
    )).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05);
  }

  Widget _buildLatinTerm(Question question, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: theme.colorScheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text('🔬 Latince: ${question.latinTerm}',
          style: GoogleFonts.poppins(fontSize: 13, fontStyle: FontStyle.italic, color: theme.colorScheme.secondary)),
    );
  }

  // ============================================================
  // TEST ŞIKLARI
  // ============================================================
  Widget _buildTestOptions(Question question, ThemeData theme, Color primary, bool isAnswered) {
    return Column(
      children: question.options!.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final isSelected = _selectedOption == option;
        final isCorrect = option == question.correctAnswer;

        Color borderColor, bgColor;

        if (isAnswered) {
          if (isCorrect) {
            borderColor = Colors.greenAccent; bgColor = Colors.greenAccent.withOpacity(0.1);
          } else if (isSelected && !isCorrect) {
            borderColor = Colors.redAccent; bgColor = Colors.redAccent.withOpacity(0.1);
          } else {
            borderColor = theme.dividerColor; bgColor = Colors.transparent;
          }
        } else {
          borderColor = isSelected ? primary : theme.dividerColor;
          bgColor = isSelected ? primary.withOpacity(0.08) : Colors.transparent;
        }

        final letters = ['A', 'B', 'C', 'D'];

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: isAnswered ? null : () => setState(() => _selectedOption = option),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      color: isSelected && !isAnswered ? primary.withOpacity(0.2) : theme.cardColor),
                    child: Center(
                      child: isAnswered && isCorrect
                          ? const Icon(Icons.check, color: Colors.greenAccent, size: 18)
                          : isAnswered && isSelected && !isCorrect
                              ? const Icon(Icons.close, color: Colors.redAccent, size: 18)
                              : Text(letters[index], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Text(option, style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: theme.colorScheme.onSurface,
                  ))),
                ],
              ),
            ),
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 100 * index), duration: 400.ms);
      }).toList(),
    );
  }

  // ============================================================
  // AÇIK UÇLU
  // ============================================================
  Widget _buildOpenAnswer(ThemeData theme, Color primary, bool isAnswered, QuizProvider provider) {
    return Column(
      children: [
        TextField(
          controller: _openAnswerController,
          enabled: !isAnswered,
          style: GoogleFonts.poppins(color: theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: 'Cevabınızı yazın...',
            hintStyle: GoogleFonts.poppins(color: theme.colorScheme.onSurface.withOpacity(0.3)),
            filled: true, fillColor: theme.cardColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: theme.dividerColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: theme.dividerColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: primary, width: 2)),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        if (isAnswered)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: double.infinity, padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text('Doğru cevap: ${provider.currentQuestion?.correctAnswer}',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.greenAccent))),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // AÇIKLAMA
  // ============================================================
  Widget _buildExplanation(Question question, QuizProvider provider, ThemeData theme) {
    final answerData = provider.getAnswerDataForQuestion(provider.currentQuestionIndex);
    if (answerData == null) return const SizedBox();

    final isCorrect = answerData['isCorrect'] as bool;
    final userAnswer = answerData['userAnswer'] as String;

    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isCorrect ? Colors.greenAccent.withOpacity(0.3) : Colors.redAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(isCorrect ? Icons.celebration : Icons.lightbulb_outline,
                color: isCorrect ? Colors.greenAccent : Colors.amberAccent, size: 20),
            const SizedBox(width: 8),
            Text(isCorrect ? 'Doğru! 🎉' : 'Yanlış', style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700, color: isCorrect ? Colors.greenAccent : Colors.redAccent)),
          ]),
          if (!isCorrect) ...[
            const SizedBox(height: 8),
            Text('Senin cevabın: $userAnswer', style: GoogleFonts.poppins(fontSize: 13, color: Colors.redAccent.withOpacity(0.8))),
          ],
          const SizedBox(height: 6),
          Text('Doğru cevap: ${question.correctAnswer}',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.greenAccent)),
          const SizedBox(height: 10),
          Text(question.explanation, style: GoogleFonts.poppins(fontSize: 14, color: theme.colorScheme.onSurface.withOpacity(0.8), height: 1.5)),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05);
  }

  // ============================================================
  // ALT BAR
  // ============================================================
  Widget _buildBottomBar(QuizProvider provider, ThemeData theme, Color primary, bool isAnswered) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Önceki soru butonu
            if (provider.currentQuestionIndex > 0)
              SizedBox(
                height: 50, width: 50,
                child: OutlinedButton(
                  onPressed: () {
                    provider.goToQuestion(provider.currentQuestionIndex - 1);
                    _loadQuestionState(provider);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.dividerColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface.withOpacity(0.5), size: 20),
                ),
              ),

            if (provider.currentQuestionIndex > 0) const SizedBox(width: 8),

            // Atla butonu (cevaplanmamışsa)
            if (!isAnswered)
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => _skipQuestion(provider),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.orangeAccent.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text('Atla', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.orangeAccent)),
                  ),
                ),
              ),

            if (!isAnswered) const SizedBox(width: 8),

            // Cevapla / Sonraki butonu
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isAnswered) {
                      _submitAnswer(provider);
                    } else {
                      _goToNextQuestion(provider);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAnswered ? Colors.greenAccent.shade700 : primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    isAnswered
                        ? (provider.currentQuestionIndex < provider.currentQuestions.length - 1 ? 'Sonraki →' : 'Sınavı Bitir')
                        : 'Cevapla',
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DİALOGLAR
  // ============================================================
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Quiz\'den Çık', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text('İlerleme kaydedilmeyecek. Çıkmak istediğine emin misin?', style: GoogleFonts.poppins(fontSize: 14)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('İptal', style: GoogleFonts.poppins())),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text('Çık', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFinishDialog(QuizProvider provider) {
    int unanswered = provider.unansweredCount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Sınavı Bitir', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${provider.answeredCount} / ${provider.currentQuestions.length} soru cevaplandı.',
                style: GoogleFonts.poppins(fontSize: 14)),
            if (unanswered > 0) ...[
              const SizedBox(height: 8),
              Text('$unanswered soru boş. Boş sorular yanlış sayılacak.',
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.orangeAccent)),
            ],
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Devam Et', style: GoogleFonts.poppins())),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); _finishQuiz(); },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text('Bitir', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
