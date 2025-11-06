import 'package:flutter/material.dart';

/// Responsive utility class untuk dynamic sizing
class Responsive {
  /// Get responsive padding berdasarkan screen size
  static EdgeInsets getPadding(BuildContext context, {
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return EdgeInsets.all(desktop);
    } else if (width >= 768) {
      return EdgeInsets.all(tablet);
    }
    return EdgeInsets.all(mobile);
  }

  /// Get responsive spacing
  static double getSpacing(BuildContext context, double baseSpacing) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return baseSpacing * 1.5;
    } else if (width >= 768) {
      return baseSpacing * 1.2;
    }
    return baseSpacing;
  }

  /// Get max width untuk card container
  static double getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return 896; // Desktop max-width
    } else if (width >= 768) {
      return 640; // Tablet max-width
    }
    return width - 32; // Mobile dengan padding
  }

  /// Check apakah mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  /// Check apakah tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  /// Check apakah desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  /// Get icon size berdasarkan screen
  static double getIconSize(BuildContext context, {
    double mobile = 20.0,
    double tablet = 24.0,
    double desktop = 28.0,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }

  /// Get button height
  static double getButtonHeight(BuildContext context) {
    return isMobile(context) ? 48.0 : 56.0;
  }
}
