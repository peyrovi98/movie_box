import 'package:movie_box/src/domain/model/movie/movie_item.dart';

abstract interface class MovieListRepository {
  Future<List<MovieItem>> getList(String search);
}