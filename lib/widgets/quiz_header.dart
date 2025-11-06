import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

/// Reusable Quiz Header Widget
/// Menampilkan username, NIM, dan progress
class QuizHeader extends StatelessWidget {
  final String username;
  final String nim;
  final int currentQuestion;
  final int totalQuestions;

  const QuizHeader({
    super.key,
    required this.username,
    required this.nim,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackgroundLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // User Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Username & NIM
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: Responsive.getIconSize(context, mobile: 16),
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMutedLight,
                    ),
                    SizedBox(width: Responsive.getSpacing(context, 8)),
                    Expanded(
                      child: Text(
                        '$username • $nim',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Question Counter Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '$currentQuestion/$totalQuestions',
                  style: AppTextStyles.badgeText(context).copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.getSpacing(context, 12)),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: currentQuestion / totalQuestions,
              backgroundColor: isDark
                  ? AppColors.borderDark
                  : AppColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? AppColors.primaryDark : AppColors.primaryLight,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
