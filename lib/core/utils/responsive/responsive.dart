import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  // Adapted to screen width
  static double width(double value) => value.r;

  // Adapted to screen height
  static double height(double value) => value.r;

  // Adapted font size
  static double fontSize(double value) => value.sp;

  // Adapted font size
  static double fontSizeWithScreen(double value) =>
      value.sp * ScreenUtil().pixelRatio!;

  // Adapted font iconSize
  static double iconSize(double value) => value.r;

  // Device pixel density
  static double? get pixelRatio => ScreenUtil().pixelRatio;

  // Percentage of screen width
  static double percentageWidth(double percentage) => percentage.sw;

  // SizedBox with vertical spacing
  static SizedBox verticalSpacing(double value) => SizedBox(height: value.r);

  static double value(double value) => value.r;

  // SizedBox with horizontal spacing
  static SizedBox horizontalSpacing(double value) => SizedBox(width: value.r);

  // Responsive Padding (all)
  static EdgeInsets edgeInsetsAll(double value) => REdgeInsets.all(value);

  // Responsive Padding (symmetric)
  static EdgeInsets edgeInsetsSymmetric({
    double? horizontal,
    double? vertical,
  }) => EdgeInsets.symmetric(
    horizontal: horizontal?.r ?? 0,
    vertical: vertical?.r ?? 0,
  );

  // Responsive Padding (custom)
  static EdgeInsets edgeInsetsOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) => EdgeInsets.only(
    left: left?.r ?? 0,
    top: top?.r ?? 0,
    right: right?.r ?? 0,
    bottom: bottom?.r ?? 0,
  );

  // BoxConstraints with responsive dimensions
  static BoxConstraints boxConstraints({
    double? maxWidth,
    double? minWidth,
    double? maxHeight,
    double? minHeight,
  }) => BoxConstraints(
    maxWidth: maxWidth?.w ?? double.infinity,
    minWidth: minWidth?.w ?? 0,
    maxHeight: maxHeight?.h ?? double.infinity,
    minHeight: minHeight?.h ?? 0,
  );

  // Radius with responsive size
  static Radius radiusCircular(double value) => Radius.circular(value.r);

  static BorderRadius borderRadiusCircule(double value) =>
      BorderRadius.circular(value.r);

  // BorderRadius with responsive size
  static BorderRadius borderRadiusAll(double value) =>
      BorderRadius.all(Radius.circular(value.r));

  // BorderRadius with responsive custom values
  static BorderRadius borderRadiusOnly({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) => BorderRadius.only(
    topLeft: Radius.circular(topLeft?.r ?? 0),
    topRight: Radius.circular(topRight?.r ?? 0),
    bottomLeft: Radius.circular(bottomLeft?.r ?? 0),
    bottomRight: Radius.circular(bottomRight?.r ?? 0),
  );

  // BorderRadius with vertical top
  static BorderRadius borderRadiusVerticalTop(double value) =>
      BorderRadius.vertical(top: Radius.circular(value.r));

  // BorderRadius with vertical bottom
  static BorderRadius borderRadiusVerticalBottom(double value) =>
      BorderRadius.vertical(bottom: Radius.circular(value.r));

  static RoundedRectangleBorder borderRadiusOnlyTop(double value) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(value.r)),
      );
  // BorderRadius with responsive size
  static Size responsiveSize(double width, double height) =>
      Size(width.r, height.r);
}
