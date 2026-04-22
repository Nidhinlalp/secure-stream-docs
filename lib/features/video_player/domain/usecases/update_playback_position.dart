import 'package:secure_stream_docs/core/usecases/usecase.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';
import 'params.dart';

class UpdatePlaybackPositionUseCase
    implements UseCase<EitherUnit, PlaybackParams> {
  final VideoRepository repository;

  UpdatePlaybackPositionUseCase(this.repository);

  @override
  EitherUnit call(PlaybackParams params) {
    return repository.updatePlaybackPosition(params.url, params.positionMs);
  }
}
