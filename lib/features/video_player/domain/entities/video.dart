import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String url;
  final String? title;
  final String? description;
  final int lastPositionMs;
  final bool isUserProvided;
  final DateTime? updatedAt;

  const Video({
    required this.url,
    this.title,
    this.description,
    required this.lastPositionMs,
    required this.isUserProvided,
    this.updatedAt,
  });

  // ── Resume helpers ──────────────────────────────

  bool get hasResumePosition => lastPositionMs > 0;

  Duration get resumePosition => Duration(milliseconds: lastPositionMs);

  // ── copyWith ────────────────────────────────────

  Video copyWith({
    String? url,
    String? title,
    String? description,
    int? lastPositionMs,
    bool? isUserProvided,
    DateTime? updatedAt,
  }) {
    return Video(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      lastPositionMs: lastPositionMs ?? this.lastPositionMs,
      isUserProvided: isUserProvided ?? this.isUserProvided,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    url,
    title,
    description,
    lastPositionMs,
    isUserProvided,
    updatedAt,
  ];
}
