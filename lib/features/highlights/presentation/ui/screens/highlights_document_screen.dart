import 'package:flutter/material.dart';

class HighlightDocumentScreen extends StatelessWidget {
  final String documentId;
  const HighlightDocumentScreen({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Highlights of $documentId')),
      body: Center(child: Text('Highlight Screen for Document: $documentId')),
    );
  }
}
