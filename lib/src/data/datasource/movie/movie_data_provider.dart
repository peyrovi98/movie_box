import 'package:movie_box/src/domain/model/movie/movie_item.dart';

abstract interface class MovieListDataProvider {
  Future<void> createOrUpdateList(List<MovieItem> movieList);

  Future<void> createOrUpdate(MovieItem movieItem);

  Future<List<MovieItem>> getList(String search);

  Future<void> clear();
}
