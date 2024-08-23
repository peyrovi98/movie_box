import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_box/src/data/di/data_di.dart';
import 'package:movie_box/src/domain/di/domain_di.dart';
import 'package:movie_box/src/domain/usecase/check/connection/check_connection_usecase.dart';
import 'package:movie_box/src/domain/usecase/check/connection/check_connection_usecase.dart';
import 'package:movie_box/src/domain/usecase/check/connection/check_connection_usecase.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';
import 'package:sqflite/sqflite.dart';

class DI {
  static final DI _singleton = DI._internal();

  factory DI() {
    return _singleton;
  }

  DI._internal();

  final getIt = GetIt.instance;
  Database? _database;

  Future<void> initialize() async {
    _dio();
    await _db();
    DataDI();
    DomainDI();
  }

  void _dio() {
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 60),
        maxRedirects: 0,
        followRedirects: false,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
          "Platform":
              (kIsWeb ? "web" : (Platform.isAndroid ? "android" : "ios")),
        }));
    getIt.registerSingleton<Dio>(dio);
  }

  Future<void> _db() async {
    _database ??= await openDatabase('my_db.db');
    getIt.registerSingleton<Database>(_database!);
  }

  CheckConnectionUseCase getCheckConnectionUseCase() {
    return getIt<CheckConnectionUseCase>();
  }

  MovieListUseCase getMovieListUseCase() {
    return getIt<MovieListUseCase>();
  }
}
