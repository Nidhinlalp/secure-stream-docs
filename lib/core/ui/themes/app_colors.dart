import 'package:flutter/material.dart';

class AppColors {
  // ==============================
  //  BRAND COLORS
  // ==============================

  /// Primary Brand (Video / Identity)
  static const Color primary = Color(0xFF29B7CE);
  static const Color primaryDark = Color(0xFF1D9EAD);

  /// Content color on top of primary (e.g. button text/icons)
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Accent (Highlight / Action)
  static const Color accent = Color(0xFFF4B41A);

  /// Secondary Neutral
  static const Color secondary = Color(0xFF2A2B2D);

  // ==============================
  //  DARK THEME
  // ==============================

  static const Color darkBackground = Color(0xFF131315);
  static const Color darkSurface = Color(0xFF1D1D1D);
  static const Color darkCard = Color(0xFF1E1E1E);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFBABABA);

  // ==============================
  //  LIGHT THEME
  // ==============================

  static const Color lightBackground = Color(0xFFF8F8FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);

  static const Color lightTextPrimary = Color(0xFF101720);
  static const Color lightTextSecondary = Color(0xFF696969);

  // ==============================
  //  FEATURE COLORS
  // ==============================

  /// Video Player
  static const Color videoPrimary = primary;

  /// PDF Viewer
  static const Color pdfLight = Color(0xFFFFFFFF);
  static const Color pdfDark = Color(0xFF1D1D1D);

  /// Highlight
  static const Color highlight = accent;

  /// Security (Lock / Encryption)
  static const Color secure = primary;
  static const Color secureGlow = Color(0xFF2CE2F4);

  // ==============================
  //  STATES
  // ==============================

  static const Color success = Color(0xFF46D490);
  static const Color error = Color(0xFFFF5151);
  static const Color warning = Color(0xFFF2B705);

  // ==============================
  //  ICON (APP ICON SPECIFIC)
  // ==============================

  /// Dark Mode Icon Background
  static const Color iconBgDarkStart = Color(0xFF131315);
  static const Color iconBgDarkEnd = Color(0xFF000000);

  /// Light Mode Icon Background
  static const Color iconBgLight = Color(0xFFFFFFFF);

  /// Video Tile Gradient
  static const List<Color> videoGradient = [
    Color(0xFF29B7CE),
    Color(0xFF1D9EAD),
  ];

  // ==============================
  //  GRADIENTS
  // ==============================

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    colors: [Color(0xFF131315), Color(0xFF000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient videoCardGradient = LinearGradient(
    colors: [Color(0xFF29B7CE), Color(0xFF1D9EAD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==============================
  //  HELPERS
  // ==============================

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkBackground
      : lightBackground;

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkSurface
      : lightSurface;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextPrimary
      : lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextSecondary
      : lightTextSecondary;
}
