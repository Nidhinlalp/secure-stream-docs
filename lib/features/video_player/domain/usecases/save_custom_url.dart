import 'package:secure_stream_docs/core/usecases/usecase.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';
import 'params.dart';

class SaveCustomUrlUseCase implements UseCase<EitherUnit, UrlParams> {
  final VideoRepository repository;

  SaveCustomUrlUseCase(this.repository);

  @override
  EitherUnit call(UrlParams params) {
    return repository.saveCustomUrl(params.url);
  }
}
