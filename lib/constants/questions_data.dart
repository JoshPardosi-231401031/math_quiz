import '../models/question_model.dart';

/// Data 10 soal quiz
/// 5 soal Deret Aritmatika + 5 soal Deret Geometri
class QuestionsData {
  static final List<Question> questions = [
    // ========== DERET ARITMATIKA (5 soal) ==========

    Question(
      question: "Tentukan suku ke-10 dari deret aritmatika: 2, 5, 8, 11, ...",
      options: [
        QuizOption(label: "A", value: "26"),
        QuizOption(label: "B", value: "29"),
        QuizOption(label: "C", value: "32"),
        QuizOption(label: "D", value: "35"),
      ],
      correctAnswer: "B",
      category: "Deret Aritmatika",
    ),

    Question(
      question: "Jumlah 8 suku pertama dari deret aritmatika 3, 7, 11, 15, ... adalah:",
      options: [
        QuizOption(label: "A", value: "120"),
        QuizOption(label: "B", value: "136"),
        QuizOption(label: "C", value: "140"),
        QuizOption(label: "D", value: "144"),
      ],
      correctAnswer: "B",
      category: "Deret Aritmatika",
    ),

    Question(
      question: "Suku tengah dari barisan aritmatika 5, 8, 11, ..., 41 adalah:",
      options: [
        QuizOption(label: "A", value: "20"),
        QuizOption(label: "B", value: "23"),
        QuizOption(label: "C", value: "26"),
        QuizOption(label: "D", value: "29"),
      ],
      correctAnswer: "B",
      category: "Deret Aritmatika",
    ),

    Question(
      question: "Diketahui suku ke-3 adalah 10 dan suku ke-7 adalah 22. Suku pertama (U1) adalah:",
      options: [
        QuizOption(label: "A", value: "2"),
        QuizOption(label: "B", value: "4"),
        QuizOption(label: "C", value: "6"),
        QuizOption(label: "D", value: "8"),
      ],
      correctAnswer: "B",
      category: "Deret Aritmatika",
    ),

    Question(
      question: "Beda (b) dari deret aritmatika yang memiliki U5 = 17 dan U9 = 29 adalah:",
      options: [
        QuizOption(label: "A", value: "2"),
        QuizOption(label: "B", value: "3"),
        QuizOption(label: "C", value: "4"),
        QuizOption(label: "D", value: "5"),
      ],
      correctAnswer: "B",
      category: "Deret Aritmatika",
    ),

    // ========== DERET GEOMETRI (5 soal) ==========

    Question(
      question: "Tentukan suku ke-5 dari deret geometri: 2, 6, 18, 54, ...",
      options: [
        QuizOption(label: "A", value: "162"),
        QuizOption(label: "B", value: "186"),
        QuizOption(label: "C", value: "324"),
        QuizOption(label: "D", value: "486"),
      ],
      correctAnswer: "A",
      category: "Deret Geometri",
    ),

    Question(
      question: "Rasio (r) dari deret geometri 5, 15, 45, 135, ... adalah:",
      options: [
        QuizOption(label: "A", value: "2"),
        QuizOption(label: "B", value: "3"),
        QuizOption(label: "C", value: "4"),
        QuizOption(label: "D", value: "5"),
      ],
      correctAnswer: "B",
      category: "Deret Geometri",
    ),

    Question(
      question: "Jumlah 4 suku pertama dari deret geometri 4, 8, 16, 32, ... adalah:",
      options: [
        QuizOption(label: "A", value: "56"),
        QuizOption(label: "B", value: "60"),
        QuizOption(label: "C", value: "64"),
        QuizOption(label: "D", value: "68"),
      ],
      correctAnswer: "B",
      category: "Deret Geometri",
    ),

    Question(
      question: "Suku ke-6 dari barisan geometri dengan U1 = 3 dan r = 2 adalah:",
      options: [
        QuizOption(label: "A", value: "48"),
        QuizOption(label: "B", value: "64"),
        QuizOption(label: "C", value: "96"),
        QuizOption(label: "D", value: "128"),
      ],
      correctAnswer: "C",
      category: "Deret Geometri",
    ),

    Question(
      question: "Diketahui deret geometri 1, 3, 9, 27, ... Jumlah 5 suku pertama adalah:",
      options: [
        QuizOption(label: "A", value: "121"),
        QuizOption(label: "B", value: "161"),
        QuizOption(label: "C", value: "181"),
        QuizOption(label: "D", value: "243"),
      ],
      correctAnswer: "A",
      category: "Deret Geometri",
    ),
  ];
}
