import 'package:movie_box/src/domain/model/movie_item.dart';

abstract interface class MovieListRepository {
  Future<List<MovieItem>> getList(String search);
}