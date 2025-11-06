import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

/// Reusable Answer Option Button (A/B/C/D)
class AnswerOption extends StatelessWidget {
  final String label; // A, B, C, D
  final String value; // Text jawaban
  final VoidCallback? onTap;
  final bool isSelected;
  final bool showFeedback;
  final bool isCorrect;

  const AnswerOption({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
    this.isSelected = false,
    this.showFeedback = false,
    this.isCorrect = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    // Determine colors based on state
    Color borderColor;
    Color backgroundColor;
    Color textColor;
    Color labelBgColor;

    if (showFeedback && isSelected) {
      // Show feedback (green if correct, red if wrong)
      if (isCorrect) {
        borderColor = AppColors.successLight;
        backgroundColor = AppColors.successLight;
        textColor = AppColors.white;
        labelBgColor = AppColors.white.withOpacity(0.3);
      } else {
        borderColor = AppColors.errorLight;
        backgroundColor = AppColors.errorLight;
        textColor = AppColors.white;
        labelBgColor = AppColors.white.withOpacity(0.3);
      }
    } else {
      // Default state
      borderColor = isDark ? AppColors.borderDark : AppColors.borderStrongLight;
      backgroundColor = isDark
          ? AppColors.cardBackgroundDark
          : AppColors.white;
      textColor = isDark
          ? AppColors.textPrimaryDark
          : AppColors.textPrimaryLight;
      labelBgColor = isDark
          ? AppColors.primaryDark
          : AppColors.primaryLight;
    }

    return InkWell(
      onTap: showFeedback ? null : onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            // Label Badge (A/B/C/D)
            Container(
              width: isMobile ? 28 : 32,
              height: isMobile ? 28 : 32,
              decoration: BoxDecoration(
                color: labelBgColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: (showFeedback && isSelected)
                        ? AppColors.white
                        : AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(width: Responsive.getSpacing(context, 12)),

            // Answer Text
            Expanded(
              child: Text(
                value,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
