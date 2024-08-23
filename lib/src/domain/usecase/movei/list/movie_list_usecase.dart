import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/repository/movie/list/movie_list_repository.dart';

class MovieListUseCase {
  final MovieListRepository _repository;

  MovieListUseCase(this._repository);

  Future<List<MovieItem>> invoke({String search = ""}) {
    return _repository.getList(search);
  }
}