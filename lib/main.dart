import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:secure_stream_docs/core/di/main/injector.dart';
import 'package:secure_stream_docs/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pdfrxFlutterInitialize();

  // Initialize dependencies
  await DI.init();

  runApp(const MyApp());
}
