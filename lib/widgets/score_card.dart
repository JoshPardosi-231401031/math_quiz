import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

/// Reusable Score Card Widget (untuk Result Screen)
class ScoreCard extends StatelessWidget {
  final int score;
  final String label;
  final IconData icon;
  final bool isCorrect; // true = green, false = red

  const ScoreCard({
    super.key,
    required this.score,
    required this.label,
    required this.icon,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    // Colors based on isCorrect
    final bgColor = isCorrect
        ? (isDark ? AppColors.successBgDark : AppColors.successBgLight)
        : (isDark ? AppColors.errorBgDark : AppColors.errorBgLight);

    final borderColor = isCorrect
        ? AppColors.successLight
        : AppColors.errorLight;

    final iconColor = isCorrect
        ? AppColors.successLight
        : AppColors.errorLight;

    final textColor = isCorrect
        ? (isDark ? AppColors.successLight : AppColors.successTextLight)
        : (isDark ? AppColors.errorLight : AppColors.errorTextLight);

    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 24)),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: borderColor.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            icon,
            size: isMobile ? 32 : 40,
            color: iconColor,
          ),

          SizedBox(height: Responsive.getSpacing(context, 12)),

          // Score Number
          Text(
            score.toString(),
            style: AppTextStyles.scoreNumber(context).copyWith(
              color: textColor,
            ),
          ),

          SizedBox(height: Responsive.getSpacing(context, 8)),

          // Label
          Text(
            label,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
