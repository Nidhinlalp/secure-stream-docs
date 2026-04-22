import 'dart:io';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';

class FileEncryptionService {
  // 32-byte (256-bit) key — replace with a securely stored value in production.
  static const String _keyBase64 = 'SecureStreamDocsKey1234567890ABC';

  // 16-byte (128-bit) IV — fixed for deterministic decrypt in this PoC.
  static const String _ivBase64 = 'SecureStreamIV12';

  /// Reads [input], encrypts it, and writes the ciphertext to [outputPath].
  ///
  /// The AES encryption runs inside [compute()] so the main thread is never
  /// blocked by the CPU-intensive cipher work.
  Future<File> encryptFile(File input, String outputPath) async {
    final plainBytes = await input.readAsBytes();

    // Offload AES work to a background isolate.
    final encryptedBytes = await compute(
      _encryptBytesInIsolate,
      _CipherArgs(
        plainBytes: plainBytes,
        key: _keyBase64,
        iv: _ivBase64,
        encrypt: true,
      ),
    );

    final outFile = File(outputPath);
    await outFile.writeAsBytes(encryptedBytes, flush: true);
    return outFile;
  }

  /// Reads [input] (ciphertext), decrypts it, and writes plaintext to [outputPath].
  ///
  /// The AES decryption runs inside [compute()] so the main thread (and
  /// therefore the UI) is never blocked during the PDF-open flow.
  Future<File> decryptFile(File input, String outputPath) async {
    final cipherBytes = await input.readAsBytes();

    // Offload AES work to a background isolate — fixes the UI freeze on open.
    final decryptedBytes = await compute(
      _decryptBytesInIsolate,
      _CipherArgs(
        plainBytes: cipherBytes,
        key: _keyBase64,
        iv: _ivBase64,
        encrypt: false,
      ),
    );

    final outFile = File(outputPath);
    await outFile.writeAsBytes(decryptedBytes, flush: true);
    return outFile;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Isolate helpers — must be top-level functions (compute requirement).
// These run in a separate Dart isolate with no access to the main isolate heap.
// ─────────────────────────────────────────────────────────────────────────────

/// Message passed into the isolate. Holds all data needed for cipher work
/// because isolates cannot share memory.
class _CipherArgs {
  final Uint8List plainBytes;
  final String key;
  final String iv;
  final bool encrypt;

  const _CipherArgs({
    required this.plainBytes,
    required this.key,
    required this.iv,
    required this.encrypt,
  });
}

/// Top-level encrypt function — runs inside a background isolate via compute().
Uint8List _encryptBytesInIsolate(_CipherArgs args) {
  final encrypter = enc.Encrypter(
    enc.AES(enc.Key.fromUtf8(args.key), mode: enc.AESMode.cbc),
  );
  final iv = enc.IV.fromUtf8(args.iv);
  final encrypted = encrypter.encryptBytes(args.plainBytes, iv: iv);
  return encrypted.bytes;
}

/// Top-level decrypt function — runs inside a background isolate via compute().
Uint8List _decryptBytesInIsolate(_CipherArgs args) {
  final encrypter = enc.Encrypter(
    enc.AES(enc.Key.fromUtf8(args.key), mode: enc.AESMode.cbc),
  );
  final iv = enc.IV.fromUtf8(args.iv);
  return Uint8List.fromList(
    encrypter.decryptBytes(enc.Encrypted(args.plainBytes), iv: iv),
  );
}
