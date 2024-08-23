import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_box/src/data/datasource/movie/movie_api_data_provider.dart';
import 'package:movie_box/src/data/datasource/movie/movie_local_data_provider.dart';
import 'package:movie_box/src/data/repository/check/connection/check_connection_repository_impl.dart';
import 'package:movie_box/src/data/repository/movie/list/movie_list_repository_impl.dart';
import 'package:movie_box/src/data/source/server/web_service.dart';
import 'package:movie_box/src/domain/repository/check/connection/check_connection_repository.dart';
import 'package:movie_box/src/domain/repository/movie/list/movie_list_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class DataDI {
  final getIt = GetIt.instance;

  DataDI() {
    _webservice();
    _checkConnectionRepository();
    _movieRepository();
  }

  void _webservice() {
    var webservice = WebService(getIt<Dio>());
    getIt.registerSingleton<WebService>(webservice);
  }

  void _checkConnectionRepository() {
    getIt.registerSingleton<CheckConnectionRepository>(
        CheckConnectionRepositoryImpl());
  }

  void _movieRepository() {
    MovieListApiDataProvider apiDataProvider =
        MovieListApiDataProvider(getIt<WebService>());
    MovieListLocalDataProvider localDataProvider =
        MovieListLocalDataProvider(getIt<Database>());
    getIt.registerSingleton<MovieListRepository>(
        MovieListRepositoryImpl(apiDataProvider, localDataProvider));
  }
}
