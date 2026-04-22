import 'package:flutter/material.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/utils/responsive/responsive.dart';

/// ==========================================
/// 🎯 App Text Style Helper
/// ==========================================
class AppTextStyle {
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color _primaryText(BuildContext context) =>
      _isDark(context) ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

  /// ==============================
  /// TEXT ACCESSORS
  /// ==============================

  static TextStyle? displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge;

  static TextStyle? displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium;

  static TextStyle? displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall;

  static TextStyle? headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge;

  static TextStyle? headlineMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium;

  static TextStyle? headlineSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall;

  static TextStyle? titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;

  static TextStyle? titleMedium(BuildContext context, {double opacity = 1.0}) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
        color: _primaryText(context).withValues(alpha: opacity),
      );

  static TextStyle? titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall;

  static TextStyle? bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge;

  static TextStyle? bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium;

  static TextStyle? bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall;

  static TextStyle? labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge;

  static TextStyle? labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium;

  static TextStyle? labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall;

  /// ==============================
  /// CUSTOM TEXT STYLE
  /// ==============================

  static TextStyle custom({
    required BuildContext context,
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double letterSpacing = 0,
    double? height,
  }) {
    return TextStyle(
      fontSize: Responsive.fontSize(fontSize),
      fontWeight: fontWeight,
      color: color ?? _primaryText(context),
      letterSpacing: letterSpacing,
      height: height != null ? height / fontSize : null,
    );
  }
}

/// ==========================================
/// 🎨 App Text Theme (Light & Dark)
/// ==========================================
class AppTextTheme {
  static TextStyle _buildTextStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontSize: Responsive.fontSize(fontSize),
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height != null ? height / fontSize : null,
    );
  }

  static TextTheme buildTextTheme(Color color) {
    return TextTheme(
      /// BODY
      bodySmall: _buildTextStyle(
        fontSize: AppSizses.m,
        fontWeight: FontWeight.w400,
        height: 15,
        color: color,
      ),
      bodyMedium: _buildTextStyle(
        fontSize: AppSizses.m1,
        fontWeight: FontWeight.w400,
        height: 18,
        color: color,
        letterSpacing: 0.25,
      ),
      bodyLarge: _buildTextStyle(
        fontSize: AppSizses.l,
        fontWeight: FontWeight.w400,
        height: 20,
        color: color,
        letterSpacing: 0.15,
      ),

      /// LABEL
      labelSmall: _buildTextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 14,
        color: color,
        letterSpacing: 0.5,
      ),
      labelMedium: _buildTextStyle(
        fontSize: AppSizses.m,
        fontWeight: FontWeight.w500,
        height: 16,
        color: color,
        letterSpacing: 0.5,
      ),
      labelLarge: _buildTextStyle(
        fontSize: AppSizses.m1,
        fontWeight: FontWeight.w500,
        height: 18,
        color: color,
        letterSpacing: 0.5,
      ),

      /// TITLE
      titleSmall: _buildTextStyle(
        fontSize: AppSizses.m1,
        fontWeight: FontWeight.w500,
        height: 18,
        color: color,
      ),
      titleMedium: _buildTextStyle(
        fontSize: AppSizses.l,
        fontWeight: FontWeight.w500,
        height: 20,
        color: color,
      ),
      titleLarge: _buildTextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 26,
        color: color,
      ),

      /// HEADLINE
      headlineSmall: _buildTextStyle(
        fontSize: AppSizses.l2,
        fontWeight: FontWeight.w500,
        height: 30,
        color: color,
      ),
      headlineMedium: _buildTextStyle(
        fontSize: AppSizses.l3,
        fontWeight: FontWeight.w600,
        height: 34,
        color: color,
      ),
      headlineLarge: _buildTextStyle(
        fontSize: AppSizses.xl,
        fontWeight: FontWeight.w700,
        height: 36,
        color: color,
      ),

      /// DISPLAY
      displaySmall: _buildTextStyle(
        fontSize: AppSizses.xl1,
        fontWeight: FontWeight.w700,
        height: 43,
        color: color,
      ),
      displayMedium: _buildTextStyle(
        fontSize: AppSizses.xl2,
        fontWeight: FontWeight.w800,
        height: 50,
        color: color,
      ),
      displayLarge: _buildTextStyle(
        fontSize: AppSizses.xl3,
        fontWeight: FontWeight.w900,
        height: 56,
        color: color,
      ),
    );
  }

  /// 🎯 FINAL THEMES
  static final TextTheme lightTextTheme = buildTextTheme(
    AppColors.lightTextPrimary,
  );

  static final TextTheme darkTextTheme = buildTextTheme(
    AppColors.darkTextPrimary,
  );
}
