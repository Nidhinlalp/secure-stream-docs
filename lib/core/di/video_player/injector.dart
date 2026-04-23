import 'package:secure_stream_docs/core/di/main/injector.dart';
import 'package:secure_stream_docs/core/local/local_storage_client.dart';
import 'package:secure_stream_docs/features/video_player/data/datasource/local/local_video_data_source.dart';
import 'package:secure_stream_docs/features/video_player/data/datasource/local/local_video_data_source_impl.dart';
import 'package:secure_stream_docs/features/video_player/data/repositories/video_repository_impl.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/clear_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/delete_custom_url.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_last_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_or_create_video.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/save_custom_url.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/update_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';

part 'injector.video_player.dart';
