import 'package:movie_box/src/domain/model/movie_item.dart';

abstract interface class MovieListDataProvider<T> {
  Future<T> getList(String search);
}