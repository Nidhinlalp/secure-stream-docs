import 'package:secure_stream_docs/core/usecases/usecase.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/params.dart';

class GetOrCreateVideoUseCase
    implements UseCase<EitherFailure<Video>, UrlParams> {
  final VideoRepository repository;

  GetOrCreateVideoUseCase(this.repository);

  @override
  EitherFailure<Video> call(UrlParams params) {
    return repository.getOrCreateVideo(params.url);
  }
}
