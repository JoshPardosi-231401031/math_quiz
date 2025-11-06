/// Model untuk opsi jawaban quiz
class QuizOption {
  final String label; // A, B, C, D
  final String value; // Nilai jawaban

  QuizOption({
    required this.label,
    required this.value,
  });
}

/// Model untuk pertanyaan quiz
class Question {
  final String question; // Text pertanyaan
  final List<QuizOption> options; // List opsi A-D
  final String correctAnswer; // Label jawaban benar (A/B/C/D)
  final String category; // Kategori: Deret Aritmatika atau Deret Geometri

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.category,
  });

  /// Check apakah jawaban benar
  bool isCorrectAnswer(String answer) {
    return answer == correctAnswer;
  }
}
