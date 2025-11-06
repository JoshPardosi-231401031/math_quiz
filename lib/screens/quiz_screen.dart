import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';
import '../widgets/quiz_header.dart';
import '../widgets/badge_widget.dart';
import '../widgets/answer_option.dart';
import '../widgets/progress_bar.dart';
import 'result_screen.dart';

/// Quiz Screen - 10 Soal Quiz
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _handleAnswer(BuildContext context, String answer) {
    final provider = Provider.of<QuizProvider>(context, listen: false);

    // Submit answer
    provider.submitAnswer(answer);

    // Delay 1 detik untuk feedback, lalu next question
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!context.mounted) return;

      if (provider.isLastQuestion) {
        // Navigate to result screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultScreen(),
          ),
        );
      } else {
        // Next question
        provider.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxWidth = Responsive.getMaxWidth(context);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,

      // App Bar
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Confirm exit
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Keluar dari Quiz?'),
                content: const Text(
                  'Progress Anda akan hilang jika keluar.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Back to home
                    },
                    child: const Text('Keluar'),
                  ),
                ],
              ),
            );
          },
        ),
        title: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            return Text(
              'Soal ${provider.progress}/${provider.totalQuestions}',
              style: AppTextStyles.headingSmall(context).copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            );
          },
        ),
      ),

      // Body
      body: Center(
        child: SingleChildScrollView(
          padding: Responsive.getPadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Consumer<QuizProvider>(
              builder: (context, provider, _) {
                final question = provider.currentQuestion;
                final currentAnswer = provider.getAnswerForQuestion(
                  provider.currentQuestionIndex,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // User Info & Progress
                    QuizHeader(
                      username: provider.username,
                      nim: provider.nim,
                      currentQuestion: provider.progress,
                      totalQuestions: provider.totalQuestions,
                    ),

                    SizedBox(height: Responsive.getSpacing(context, 24)),

                    // Question Card
                    Container(
                      padding: EdgeInsets.all(
                        Responsive.getSpacing(context, 32),
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.cardBackgroundDark
                            : AppColors.cardBackgroundLight,
                        border: Border.all(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Badge & Progress Dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BadgeWidget(
                                text: provider.currentCategory,
                                type: BadgeType.primary,
                              ),

                              // Progress Dots
                              ProgressDots(
                                total: provider.totalQuestions,
                                current: provider.currentQuestionIndex,
                                completed: provider.currentQuestionIndex,
                              ),
                            ],
                          ),

                          SizedBox(height: Responsive.getSpacing(context, 24)),

                          // Question Text
                          Container(
                            padding: EdgeInsets.all(
                              Responsive.getSpacing(context, 20),
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.backgroundDark
                                  : AppColors.backgroundLight,
                              border: Border.all(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              question.question,
                              style: AppTextStyles.bodyLarge(context).copyWith(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),

                          SizedBox(height: Responsive.getSpacing(context, 24)),

                          // Answer Options
                          ...question.options.map((option) {
                            final isSelected = currentAnswer == option.label;
                            final isCorrect =
                                option.label == question.correctAnswer;

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: Responsive.getSpacing(context, 12),
                              ),
                              child: AnswerOption(
                                label: option.label,
                                value: option.value,
                                isSelected: isSelected,
                                showFeedback: provider.showFeedback,
                                isCorrect: isCorrect,
                                onTap: () => _handleAnswer(context, option.label),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
