import 'package:get_it/get_it.dart';
import 'package:movie_box/src/domain/repository/check/connection/check_connection_repository.dart';
import 'package:movie_box/src/domain/repository/movie/list/movie_list_repository.dart';
import 'package:movie_box/src/domain/usecase/check/connection/check_connection_usecase.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';

class DomainDI {
  final getIt = GetIt.instance;

  DomainDI() {
    getIt.registerSingleton<CheckConnectionUseCase>(CheckConnectionUseCase(getIt<CheckConnectionRepository>()));
    getIt.registerSingleton<MovieListUseCase>(MovieListUseCase(getIt<MovieListRepository>()));
  }
}
