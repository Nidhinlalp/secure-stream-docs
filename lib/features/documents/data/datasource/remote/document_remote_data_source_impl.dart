import 'dart:async';
import 'dart:io';
import 'package:secure_stream_docs/core/network/network_client.dart';
import 'package:secure_stream_docs/core/utils/constants/app_constants.dart';
import 'package:secure_stream_docs/features/documents/data/datasource/remote/document_remote_data_source.dart';
import 'package:secure_stream_docs/features/documents/data/models/document_model.dart';

class DocumentRemoteDataSourceImpl implements DocumentRemoteDataSource {
  final NetworkClient networkClient;

  DocumentRemoteDataSourceImpl(this.networkClient);

  // ─────────────────────────────────────────────────────────────────────────
  // Download PDF from remote server and stream progress.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Stream<double> downloadFile({required String url, required String savePath}) {
    final controller = StreamController<double>();
    final file = File(savePath);

    networkClient.dio
        .download(
          url,
          file.path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final progress = received / total;
              controller.add(progress);
            }
          },
        )
        .then((_) {
          controller.close();
        })
        .catchError((error) {
          if (!controller.isClosed) {
            controller.addError(error);
            controller.close();
          }
        });

    return controller.stream;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch list of documents from remote server using mock data.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<List<DocumentModel>> fetchDocuments() async {
    return AppConstants.samplePdfs.map((pdfData) {
      return DocumentModel()
        ..docId = pdfData['id'] as String
        ..name = pdfData['name'] as String
        ..url = pdfData['url'] as String
        ..isDownloaded = false
        ..localPath = null
        ..progress = 0.0;
    }).toList();
  }
}
