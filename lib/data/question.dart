class Question {
  final String id;
  final String category;
  final String subcategory;
  final String type; // 'test', 'open'
  final String difficulty; // 'easy', 'medium', 'hard'
  final String questionText;
  final String? questionTextReverse;
  final List<String>? options;
  final String correctAnswer;
  final String? latinTerm;
  final String explanation;
  final String? imageUrl; // İnternetten görsel URL'si

  Question({
    required this.id,
    required this.category,
    required this.subcategory,
    required this.type,
    required this.difficulty,
    required this.questionText,
    this.questionTextReverse,
    this.options,
    required this.correctAnswer,
    this.latinTerm,
    required this.explanation,
    this.imageUrl,
  });

  bool checkAnswer(String userAnswer) {
    final normalizedUser = userAnswer.trim().toLowerCase()
        .replaceAll('ı', 'i').replaceAll('ö', 'o').replaceAll('ü', 'u')
        .replaceAll('ş', 's').replaceAll('ç', 'c').replaceAll('ğ', 'g');
    final normalizedCorrect = correctAnswer.trim().toLowerCase()
        .replaceAll('ı', 'i').replaceAll('ö', 'o').replaceAll('ü', 'u')
        .replaceAll('ş', 's').replaceAll('ç', 'c').replaceAll('ğ', 'g');
    return normalizedUser == normalizedCorrect;
  }

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'subcategory': subcategory,
      'type': type,
      'difficulty': difficulty,
      'questionText': questionText,
      'questionTextReverse': questionTextReverse,
      'options': options,
      'correctAnswer': correctAnswer,
      'latinTerm': latinTerm,
      'explanation': explanation,
      'imageUrl': imageUrl,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      category: json['category'],
      subcategory: json['subcategory'],
      type: json['type'],
      difficulty: json['difficulty'],
      questionText: json['questionText'],
      questionTextReverse: json['questionTextReverse'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      correctAnswer: json['correctAnswer'],
      latinTerm: json['latinTerm'],
      explanation: json['explanation'],
      imageUrl: json['imageUrl'],
    );
  }
}
