import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable Progress Bar Widget
class ProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;

  const ProgressBar({
    super.key,
    required this.progress,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(9999),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: isDark
            ? AppColors.borderDark
            : AppColors.borderLight,
        valueColor: AlwaysStoppedAnimation<Color>(
          isDark ? AppColors.primaryDark : AppColors.primaryLight,
        ),
        minHeight: height,
      ),
    );
  }
}

/// Progress Dots Widget (alternatif untuk quiz progress)
class ProgressDots extends StatelessWidget {
  final int total; // Total questions
  final int current; // Current question (0-based index)
  final int completed; // Jumlah yang sudah dijawab

  const ProgressDots({
    super.key,
    required this.total,
    required this.current,
    this.completed = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        Color dotColor;
        double dotWidth;

        if (index < current) {
          // Completed
          dotColor = AppColors.successLight;
          dotWidth = 8;
        } else if (index == current) {
          // Current
          dotColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
          dotWidth = 16; // Lebih panjang untuk current
        } else {
          // Pending
          dotColor = isDark ? AppColors.borderDark : AppColors.borderLight;
          dotWidth = 8;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: dotWidth,
          height: 8,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(9999),
          ),
        );
      }),
    );
  }
}
