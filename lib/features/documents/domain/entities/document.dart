import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final String id;
  final String name;
  final String url;

  final bool isDownloaded;
  final bool isDownloading;
  final String? localPath; // encrypted file path
  final double progress; // 0 → 1

  const Document({
    required this.id,
    required this.name,
    required this.url,
    required this.isDownloaded,
    required this.isDownloading,
    this.localPath,
    this.progress = 0,
  });

  Document copyWith({
    bool? isDownloaded,
    String? localPath,
    double? progress,
    bool? isDownloading,
  }) {
    return Document(
      id: id,
      name: name,
      url: url,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isDownloading: isDownloading ?? this.isDownloading,
      localPath: localPath ?? this.localPath,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    url,
    isDownloaded,
    isDownloading,
    localPath,
    progress,
  ];
}
