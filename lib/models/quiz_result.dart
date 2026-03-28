class QuizResult {
  final String id;
  final String category;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final DateTime date;
  final int timeTaken;
  final List<Map<String, dynamic>> answeredQuestions;

  QuizResult({
    required this.id,
    required this.category,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.date,
    required this.timeTaken,
    required this.answeredQuestions,
  });

  double get scorePercentage =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  String get grade {
    if (scorePercentage >= 90) return 'A+';
    if (scorePercentage >= 80) return 'A';
    if (scorePercentage >= 70) return 'B';
    if (scorePercentage >= 60) return 'C';
    if (scorePercentage >= 50) return 'D';
    return 'F';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'date': date.toIso8601String(),
      'timeTaken': timeTaken,
    };
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'],
      category: json['category'],
      totalQuestions: json['totalQuestions'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      date: DateTime.parse(json['date']),
      timeTaken: json['timeTaken'],
      answeredQuestions: [],
    );
  }
}
