import 'package:secure_stream_docs/core/usecases/usecase.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/params.dart';

class GetLastPlaybackPositionUseCase
    implements UseCase<EitherFailure<int>, UrlParams> {
  final VideoRepository repository;

  GetLastPlaybackPositionUseCase(this.repository);

  @override
  EitherFailure<int> call(UrlParams params) {
    return repository.getLastPosition(params.url);
  }
}
