class AppConstants {
  /// HLS Stream (Working Test Stream - Big Buck Bunny)
  static const String defaultHlsStream =
      'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8';

  /// Video Samples
  static const List<Map<String, dynamic>> sampleVideos = [
    {
      'id': 'vid_001',
      'title': 'Intro to Flutter',
      'description': 'Learn basics of Flutter framework',
      'thumbnail': 'https://img.youtube.com/vi/fq4N0hgOWzU/maxresdefault.jpg',
      'url': defaultHlsStream,
      'duration': '10:00',
    },
  ];

  /// PDF Samples
  static const List<Map<String, dynamic>> samplePdfs = [
    {
      'id': 'pdf_001',
      'name': 'Flutter Documentation',
      'description': 'Official Flutter PDF documentation',
      'size': '2.5 MB',
      'isDownloaded': false,
      'url':
          'https://opensource.adobe.com/dc-acrobat-sdk-docs/pdfstandards/PDF32000_2008.pdf',
    },
    {
      'id': 'pdf_002',
      'name': 'Dart Language Tour',
      'description': 'Complete Dart overview',
      'size': '1.2 MB',
      'isDownloaded': false,
      'url':
          'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_PDF.pdf',
    },
    {
      'id': 'pdf_003',
      'name': 'Sample Report',
      'description': 'Example PDF for testing highlights',
      'size': '3.1 MB',
      'isDownloaded': false,
      'url':
          'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_PDF.pdf',
    },
  ];
}
