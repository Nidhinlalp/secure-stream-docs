import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';

class AppTheme {
  /// ==============================
  /// SYSTEM UI
  /// ==============================

  static SystemUiOverlayStyle lightUIStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColors.lightBackground,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle darkUIStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColors.darkBackground,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  /// ==============================
  /// THEME BUILDER
  /// ==============================

  static ThemeData _buildTheme({required Brightness brightness}) {
    final bool isDark = brightness == Brightness.dark;

    final Color primary = AppColors.primary;
    final Color background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final Color surface = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final Color text = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,

      /// COLOR SCHEME (modern Flutter)
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        secondary: AppColors.accent,
        surface: surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: text,
        onError: Colors.white,
      ),

      /// BACKGROUND
      scaffoldBackgroundColor: background,
      canvasColor: surface,

      /// TEXT
      textTheme: isDark
          ? AppTextTheme.darkTextTheme
          : AppTextTheme.lightTextTheme,

      /// APP BAR
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        systemOverlayStyle: isDark ? darkUIStyle : lightUIStyle,
        titleTextStyle: TextStyle(
          color: text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: text),
      ),

      /// INPUT FIELDS
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.secondary.withValues(alpha: 0.3),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.secondary.withValues(alpha: 0.3),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),

        errorStyle: TextStyle(color: AppColors.error, fontSize: 12),
      ),

      /// BUTTONS (optional but useful)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  /// ==============================
  /// FINAL THEMES
  /// ==============================

  static final ThemeData lightTheme = _buildTheme(brightness: Brightness.light);

  static final ThemeData darkTheme = _buildTheme(brightness: Brightness.dark);
}
