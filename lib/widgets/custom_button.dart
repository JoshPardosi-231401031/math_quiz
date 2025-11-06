import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

/// Reusable Custom Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonHeight = Responsive.getButtonHeight(context);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (isDark ? AppColors.primaryDark : AppColors.primaryLight),
          foregroundColor: textColor ?? AppColors.white,
          disabledBackgroundColor: isDark
              ? AppColors.borderDark
              : AppColors.borderLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.05),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.getSpacing(context, 24),
            vertical: Responsive.getSpacing(context, 12),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              textColor ?? AppColors.white,
            ),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: Responsive.getIconSize(context, mobile: 20)),
              SizedBox(width: Responsive.getSpacing(context, 8)),
            ],
            Text(
              text,
              style: AppTextStyles.buttonText(context).copyWith(
                color: textColor ?? AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Outline Button Variant
class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;

  const CustomOutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonHeight = Responsive.getButtonHeight(context);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? AppColors.primaryDark : AppColors.primaryLight,
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.getSpacing(context, 24),
            vertical: Responsive.getSpacing(context, 12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: Responsive.getIconSize(context, mobile: 20)),
              SizedBox(width: Responsive.getSpacing(context, 8)),
            ],
            Text(
              text,
              style: AppTextStyles.buttonText(context),
            ),
          ],
        ),
      ),
    );
  }
}
