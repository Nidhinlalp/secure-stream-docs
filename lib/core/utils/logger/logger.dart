// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';

void logger(String message, {String? tag}) {
  if (kDebugMode || kProfileMode) {
    if (tag != null) {
      print('=====> $tag: $message');
    } else {
      print('=====> $message');
    }
  }
}

// Error
void errorLogger(String message, {String? tag}) {
  if (kDebugMode || kProfileMode) {
    if (tag != null) {
      print('=====> $tag: $message');
    } else {
      print('=====> $message');
    }
  }
}
