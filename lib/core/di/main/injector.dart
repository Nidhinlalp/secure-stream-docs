import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:isar_community/isar.dart';
import 'package:secure_stream_docs/core/di/document/injector.dart'
    as document_di;
import 'package:secure_stream_docs/core/di/video_player/injector.dart'
    as video_di;
import 'package:secure_stream_docs/core/local/isar_initializer.dart';
import 'package:secure_stream_docs/core/local/local_storage_client.dart';
import 'package:secure_stream_docs/core/network/network_client.dart';
import 'package:secure_stream_docs/core/network/network_info.dart';
import 'package:secure_stream_docs/core/utils/logger/logger.dart';

part 'injector.main.dart';
