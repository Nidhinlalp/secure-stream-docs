import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/di/main/injector.dart';
import 'package:secure_stream_docs/core/utils/constants/app_constants.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/document/documents_bloc.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';

import 'package:secure_stream_docs/core/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DI.fetch<VideoPlayerBloc>()
                  ..add(const LoadVideo(AppConstants.defaultHlsStream)),
            lazy: false,
          ),
          BlocProvider(
            create: (context) =>
                DI.fetch<DocumentsBloc>()..add(LoadDocuments()),
            lazy: false,
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Secure Stream',
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
