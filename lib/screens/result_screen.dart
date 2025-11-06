import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/score_card.dart';

/// Result Screen - Tampilkan Score
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

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
        automaticallyImplyLeading: false, // No back button
        title: Text(
          'Hasil Quiz',
          style: AppTextStyles.headingSmall(context).copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
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
                return Container(
                  padding: EdgeInsets.all(
                    Responsive.getSpacing(context, 40),
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
                      // Trophy Icon
                      Center(
                        child: Container(
                          width: Responsive.isMobile(context) ? 64 : 80,
                          height: Responsive.isMobile(context) ? 64 : 80,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.primaryDarkBg
                                : AppColors.primaryLightBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.emoji_events_outlined,
                            size: Responsive.isMobile(context) ? 32 : 40,
                            color: isDark
                                ? AppColors.primaryDark
                                : AppColors.primaryLight,
                          ),
                        ),
                      ),

                      SizedBox(height: Responsive.getSpacing(context, 24)),

                      // Title
                      Text(
                        'Quiz Done!',
                        style: AppTextStyles.headingLarge(context).copyWith(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: Responsive.getSpacing(context, 8)),

                      // User Info
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.backgroundDark
                              : AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: Responsive.getIconSize(context, mobile: 16),
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textMutedLight,
                            ),
                            SizedBox(width: Responsive.getSpacing(context, 8)),
                            Text(
                              '${provider.username} • ${provider.nim}',
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Responsive.getSpacing(context, 32)),

                      // Score Cards
                      Row(
                        children: [
                          // Correct Score
                          Expanded(
                            child: ScoreCard(
                              score: provider.correctAnswersCount,
                              label: 'Jawaban Benar',
                              icon: Icons.check_circle_outline,
                              isCorrect: true,
                            ),
                          ),

                          SizedBox(width: Responsive.getSpacing(context, 24)),

                          // Incorrect Score
                          Expanded(
                            child: ScoreCard(
                              score: provider.incorrectAnswersCount,
                              label: 'Jawaban Salah',
                              icon: Icons.cancel_outlined,
                              isCorrect: false,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: Responsive.getSpacing(context, 32)),

                      // Divider
                      Divider(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),

                      SizedBox(height: Responsive.getSpacing(context, 32)),

                      // Back to Home Button
                      CustomButton(
                        text: 'Kembali ke Home',
                        icon: Icons.home_outlined,
                        onPressed: () {
                          // Clear quiz state
                          provider.clearAll();

                          // Navigate back to home (pop all routes)
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),

                      SizedBox(height: Responsive.getSpacing(context, 12)),

                      // Restart Quiz Button (Optional)
                      CustomButton(
                        text: 'Ulangi Quiz',
                        icon: Icons.refresh,
                        backgroundColor: isDark
                            ? AppColors.cardHoverDark
                            : AppColors.cardHoverLight,
                        textColor: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        onPressed: () {
                          // Reset quiz
                          provider.resetQuiz();

                          // Pop to quiz screen
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
