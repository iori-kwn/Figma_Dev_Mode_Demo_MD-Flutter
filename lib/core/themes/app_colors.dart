import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Based on Material 3 Design System
  static const Color primarySeed = Color(0xFF6750A4);
  
  // Success Colors
  static const Color success = Color(0xFF00A63E);
  static const Color successContainer = Color(0xFFDCFCE7);
  
  // Warning Colors
  static const Color warning = Color(0xFFEBA300);
  static const Color warningContainer = Color(0xFFFFF3CD);
  
  // Error Colors
  static const Color error = Color(0xFFD4183D);
  static const Color errorContainer = Color(0xFFFDEDF0);
  
  // Neutral Colors
  static const Color neutral10 = Color(0xFF1D1B20);
  static const Color neutral20 = Color(0xFF313033);
  static const Color neutral50 = Color(0xFF717182);
  static const Color neutral90 = Color(0xFFECEEF2);
  static const Color neutral95 = Color(0xFFF5F5F5);
  static const Color neutral99 = Color(0xFFFFFBFE);
  
  // Additional UI Colors
  static const Color divider = Color(0xFFCAC4D0);
  static const Color shadow = Color(0x1A000000);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6750A4), Color(0xFF9C4DB8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFECEEF2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Social Media Colors
  static const Color google = Color(0xFF4285F4);
  static const Color apple = Color(0xFF000000);
  static const Color facebook = Color(0xFF1877F2);
  
  // Status Colors for Progress Indicators
  static const Color progressWeak = Color(0xFFE5E7EB);
  static const Color progressMedium = Color(0xFFEBA300);
  static const Color progressStrong = Color(0xFF00C33F);
}

// Material 3 Color Extensions
extension AppColorScheme on ColorScheme {
  Color get successColor => AppColors.success;
  Color get successContainer => AppColors.successContainer;
  Color get warningColor => AppColors.warning;
  Color get warningContainer => AppColors.warningContainer;
}
