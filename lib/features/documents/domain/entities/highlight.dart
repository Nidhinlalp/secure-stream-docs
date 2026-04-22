import 'package:equatable/equatable.dart';
import 'dart:ui';

class Highlight extends Equatable {
  final String id;
  final String docId;
  final int page;
  final String text;
  final Rect position;
  final int colorValue;
  final DateTime createdAt;

  const Highlight({
    required this.id,
    required this.docId,
    required this.page,
    required this.text,
    required this.position,
    this.colorValue = 0x80FFEB3B,
    required this.createdAt,
  });

  Color get color => Color.fromARGB(
    (colorValue >> 24) & 0xFF,
    (colorValue >> 16) & 0xFF,
    (colorValue >> 8) & 0xFF,
    colorValue & 0xFF,
  );

  @override
  List<Object?> get props => [
    id,
    docId,
    page,
    text,
    position,
    colorValue,
    createdAt,
  ];
}
