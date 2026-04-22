import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizses {
  /// Sizing inspired by Tailwind CSS
  static double px = 1;

  static double px1 = 2;

  static double xs = 4.0;

  static double xs1 = 6.0;

  static double s = 8.0;

  static double s1 = 10.0;

  static double m = 12.0;

  static double m1 = 14.0;

  static double l = 16.0;

  static double l1 = 20.0;

  static double l2 = 24.0;

  static double l3 = 28.0;

  static double xl = 32.0;

  static double xl1 = 40.0;

  static double xl2 = 48.0;

  static double xl3 = 56.0;

  static double xxl = 64.0;

  static double xxl1 = 80.0;

  static double xxl2 = 96.0;

  static double xxl3 = 112.0;

  static double x = 128.0;

  static double x1 = 144.0;

  static double x2 = 160.0;

  static double x3 = 176.0;

  static const double x5 = 208.0;

  /// Spacers for height and width
  static Widget height(double value) => SizedBox(height: value.sp);

  static Widget width(double value) => SizedBox(width: value.sp);
}
