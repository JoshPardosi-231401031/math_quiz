import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

/// Reusable Custom Input Field Widget
class CustomInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLength;

  const CustomInput({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Input Field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          maxLength: maxLength,
          style: AppTextStyles.bodyRegular(context).copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            hintText: hintText ?? label,
            hintStyle: AppTextStyles.bodyRegular(context).copyWith(
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            ),

            // Prefix Icon
            prefixIcon: prefixIcon != null
                ? Icon(
              prefixIcon,
              size: Responsive.getIconSize(context, mobile: 20),
              color: isDark
                  ? AppColors.textMutedDark
                  : AppColors.textMutedLight,
            )
                : null,

            // Border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.borderDark
                    : AppColors.borderStrongLight,
              ),
            ),

            // Enabled Border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.borderDark
                    : AppColors.borderStrongLight,
              ),
            ),

            // Focused Border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,
                width: 2,
              ),
            ),

            // Error Border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.errorLight,
                width: 1,
              ),
            ),

            // Focused Error Border
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.errorLight,
                width: 2,
              ),
            ),

            // Fill Color
            filled: true,
            fillColor: isDark
                ? AppColors.cardHoverDark
                : AppColors.backgroundLight,

            // Padding
            contentPadding: EdgeInsets.symmetric(
              horizontal: Responsive.getSpacing(context, 16),
              vertical: Responsive.getSpacing(context, 12),
            ),

            // Counter (jika ada maxLength)
            counterText: '',
          ),
        ),
      ],
    );
  }
}
