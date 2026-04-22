import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_stream_docs/core/error/exceptions.dart';
import 'package:secure_stream_docs/features/video_player/data/models/video_model.dart';

/// Initializes Isar database once at app start with all schemas registered.
/// Returns the opened Isar instance for dependency injection.
class IsarInitializer {
  /// Opens Isar with all feature schemas.
  /// Call this once at app startup before any database operations.
  static Future<Isar> initialize() async {
    try {
      // If Isar is already opened, return the existing instance
      if (Isar.instanceNames.isNotEmpty) {
        return Isar.getInstance() ??
            (throw StorageException('Isar instance not found'));
      }

      // Get the application documents directory
      final dir = await getApplicationDocumentsDirectory();

      final isar = await Isar.open([VideoModelSchema], directory: dir.path);

      return isar;
    } catch (e) {
      throw StorageException('Failed to initialise local database: $e');
    }
  }
}
