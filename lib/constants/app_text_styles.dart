import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Typography System
class AppTextStyles {
  // Base font family
  static TextStyle get _baseStyle => GoogleFonts.inter();

  // ========== HEADINGS ==========

  /// Heading XL - 36px, Semi-bold
  static TextStyle headingXL(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 36),
      fontWeight: FontWeight.w600,
      height: 1.1,
    );
  }

  /// Heading Large - 32px, Semi-bold
  static TextStyle headingLarge(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 32),
      fontWeight: FontWeight.w600,
      height: 1.125,
    );
  }

  /// Heading Medium - 24px, Semi-bold
  static TextStyle headingMedium(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 24),
      fontWeight: FontWeight.w600,
      height: 1.33,
    );
  }

  /// Heading Small - 20px, Semi-bold
  static TextStyle headingSmall(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 20),
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
  }

  // ========== BODY TEXT ==========

  /// Body Large - 18px, Regular
  static TextStyle bodyLarge(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 18),
      fontWeight: FontWeight.w400,
      height: 1.56,
    );
  }

  /// Body Regular - 16px, Regular
  static TextStyle bodyRegular(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 16),
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  /// Body Medium - 14px, Medium
  static TextStyle bodyMedium(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 14),
      fontWeight: FontWeight.w500,
      height: 1.43,
    );
  }

  /// Body Small - 12px, Regular
  static TextStyle bodySmall(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 12),
      fontWeight: FontWeight.w400,
      height: 1.33,
    );
  }

  // ========== SPECIAL ==========

  /// Button Text - 14px, Medium
  static TextStyle buttonText(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 14),
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
  }

  /// Badge Text - 12px, Medium
  static TextStyle badgeText(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 12),
      fontWeight: FontWeight.w500,
    );
  }

  /// Score Number - 48px, Bold
  static TextStyle scoreNumber(BuildContext context) {
    return _baseStyle.copyWith(
      fontSize: _getResponsiveFontSize(context, 48),
      fontWeight: FontWeight.w700,
      height: 1,
    );
  }

  // ========== HELPER ==========

  /// Get responsive font size based on screen width
  static double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;

    // Base: 375px (mobile)
    // Scale factor untuk screen yang lebih besar
    if (width > 768) {
      // Tablet/Desktop - scale up sedikit
      return baseSize * 1.1;
    } else if (width < 360) {
      // Small phone - scale down sedikit
      return baseSize * 0.9;
    }

    return baseSize;
  }
}
