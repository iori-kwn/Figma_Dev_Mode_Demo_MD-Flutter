import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  // Base Font Family (using Google Fonts Roboto for web)
  static const String fontFamily = 'Roboto';

  // Material 3 Typography Scale
  static const TextTheme textTheme = TextTheme(
    // Display
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 57,
      height: 1.12,
      letterSpacing: -0.25,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 45,
      height: 1.16,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 36,
      height: 1.22,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

    // Headline
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      height: 1.25,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 28,
      height: 1.29,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      height: 1.33,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

    // Title
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      height: 1.27,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),

    // Body
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400,
    ),

    // Label
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
  );

  // Custom Typography for specific use cases
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle inputText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.50,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle helperText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400,
  );

  // Japanese-specific typography adjustments
  static const TextStyle japaneseHeadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 1.40,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle japaneseBody = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.50,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400,
  );
}

// Typography Extensions
extension AppTypographyExtensions on TextTheme {
  TextStyle get buttonStyle => AppTypography.buttonText;
  TextStyle get inputLabelStyle => AppTypography.inputLabel;
  TextStyle get inputTextStyle => AppTypography.inputText;
  TextStyle get helperTextStyle => AppTypography.helperText;
  TextStyle get errorTextStyle => AppTypography.errorText;
  TextStyle get japaneseHeadlineStyle => AppTypography.japaneseHeadline;
  TextStyle get japaneseBodyStyle => AppTypography.japaneseBody;
}
