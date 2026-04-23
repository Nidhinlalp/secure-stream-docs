import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:secure_stream_docs/core/di/main/injector.dart';
import 'package:secure_stream_docs/my_app.dart';

// ─────────────────────────────────────────────────────────────────────────
// How to run
// ─────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────
// Dev
// flutter run --flavor dev -t lib/main_dev.dart
// ─────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────
// Staging
// flutter run --flavor stage -t lib/main_stage.dart

// ─────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────
// Prod
// flutter run --flavor prod -t lib/main_prod.dart
// ─────────────────────────────────────────────────────────────────────────

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pdfrxFlutterInitialize();

  // Initialize dependencies
  await DI.init();

  runApp(const MyApp());
}
