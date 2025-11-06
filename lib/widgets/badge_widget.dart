import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Reusable Badge Widget
class BadgeWidget extends StatelessWidget {
  final String text;
  final BadgeType type;

  const BadgeWidget({
    super.key,
    required this.text,
    this.type = BadgeType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _getColors(isDark);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors['bg'],
        border: Border.all(
          color: colors['border']!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: AppTextStyles.badgeText(context).copyWith(
          color: colors['text'],
        ),
      ),
    );
  }

  Map<String, Color> _getColors(bool isDark) {
    switch (type) {
      case BadgeType.primary:
        return {
          'bg': isDark ? AppColors.primaryDarkBg : AppColors.primaryLightBg,
          'border': isDark ? AppColors.primaryDark : AppColors.primaryLight,
          'text': isDark ? AppColors.primaryDark : AppColors.primaryLight,
        };

      case BadgeType.success:
        return {
          'bg': isDark ? AppColors.successBgDark : AppColors.successBgLight,
          'border': AppColors.successLight,
          'text': isDark ? AppColors.successLight : AppColors.successTextLight,
        };

      case BadgeType.error:
        return {
          'bg': isDark ? AppColors.errorBgDark : AppColors.errorBgLight,
          'border': AppColors.errorLight,
          'text': isDark ? AppColors.errorLight : AppColors.errorTextLight,
        };

      case BadgeType.neutral:
        return {
          'bg': isDark ? AppColors.cardBackgroundDark : AppColors.cardBackgroundLight,
          'border': isDark ? AppColors.borderDark : AppColors.borderLight,
          'text': isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        };
    }
  }
}

/// Badge untuk menampilkan number (rounded)
class NumberBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const NumberBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? AppColors.primaryDark : AppColors.primaryLight),
        borderRadius: BorderRadius.circular(9999), // Fully rounded
      ),
      child: Text(
        text,
        style: AppTextStyles.badgeText(context).copyWith(
          color: textColor ?? AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum BadgeType {
  primary,
  success,
  error,
  neutral,
}
