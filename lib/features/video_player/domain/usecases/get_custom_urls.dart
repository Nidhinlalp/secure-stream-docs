import 'package:secure_stream_docs/core/usecases/usecase.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';

class GetCustomUrlsUseCase implements UseCase<EitherList<String>, NoParams> {
  final VideoRepository repository;

  GetCustomUrlsUseCase(this.repository);

  @override
  EitherList<String> call(NoParams params) {
    return repository.getCustomUrls();
  }
}
