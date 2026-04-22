class AppConstants {
  /// HLS Stream (Working Test Stream - Big Buck Bunny)
  static const String defaultHlsStream =
      'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8';

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
  ];
}
