import 'package:flutter/foundation.dart';
import '../models/question_model.dart';
import '../constants/questions_data.dart';

/// State management untuk Quiz
/// Menggunakan ChangeNotifier untuk preserve state saat rotasi
class QuizProvider with ChangeNotifier {
  // ========== STATE ==========

  String _username = '';
  String _nim = '';
  int _currentQuestionIndex = 0;
  List<String?> _answers = List.filled(10, null);
  bool _showFeedback = false;
  bool _isDarkMode = false;

  // ========== GETTERS ==========

  String get username => _username;
  String get nim => _nim;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<String?> get answers => _answers;
  bool get showFeedback => _showFeedback;
  bool get isDarkMode => _isDarkMode;

  List<Question> get questions => QuestionsData.questions;
  Question get currentQuestion => questions[_currentQuestionIndex];

  int get totalQuestions => questions.length;
  int get progress => _currentQuestionIndex + 1;
  double get progressPercentage => (progress / totalQuestions);

  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;

  // ========== ACTIONS ==========

  /// Set user info (username & NIM)
  void setUserInfo(String username, String nim) {
    _username = username;
    _nim = nim;
    notifyListeners();
  }

  /// Toggle theme (dark/light mode)
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Set theme explicitly
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  /// Submit answer untuk current question
  void submitAnswer(String answer) {
    if (_showFeedback) return; // Prevent multiple submissions

    _answers[_currentQuestionIndex] = answer;
    _showFeedback = true;
    notifyListeners();
  }

  /// Next question (dipanggil setelah delay feedback)
  void nextQuestion() {
    _showFeedback = false;

    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    }
    // Jika last question, navigation ke result screen dari UI
  }

  /// Reset quiz (untuk mulai dari awal)
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _answers = List.filled(10, null);
    _showFeedback = false;
    // Tidak reset username/nim agar bisa restart quiz dengan user sama
    notifyListeners();
  }

  /// Clear all data (logout)
  void clearAll() {
    _username = '';
    _nim = '';
    _currentQuestionIndex = 0;
    _answers = List.filled(10, null);
    _showFeedback = false;
    notifyListeners();
  }

  // ========== COMPUTED VALUES ==========

  /// Get jawaban untuk question tertentu
  String? getAnswerForQuestion(int index) {
    if (index >= 0 && index < _answers.length) {
      return _answers[index];
    }
    return null;
  }

  /// Check apakah answer benar
  bool isAnswerCorrect(int questionIndex, String answer) {
    return questions[questionIndex].correctAnswer == answer;
  }

  /// Hitung total jawaban benar
  int get correctAnswersCount {
    int count = 0;
    for (int i = 0; i < _answers.length; i++) {
      if (_answers[i] != null && isAnswerCorrect(i, _answers[i]!)) {
        count++;
      }
    }
    return count;
  }

  /// Hitung total jawaban salah
  int get incorrectAnswersCount {
    return totalQuestions - correctAnswersCount;
  }

  /// Get score (0-100)
  int get score {
    return (correctAnswersCount / totalQuestions * 100).round();
  }

  /// Get kategori current question
  String get currentCategory => currentQuestion.category;

  /// Check apakah sudah menjawab current question
  bool get hasAnsweredCurrent => _answers[_currentQuestionIndex] != null;
}
