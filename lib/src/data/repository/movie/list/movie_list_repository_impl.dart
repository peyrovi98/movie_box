import 'package:movie_box/src/data/datasource/movie/movie_data_provider.dart';
import 'package:movie_box/src/data/source/ram/ram_storage.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/repository/movie/list/movie_list_repository.dart';

class MovieListRepositoryImpl implements MovieListRepository {
  final MovieListDataProvider _apiDataProvider, _localDataProvider;

  MovieListRepositoryImpl(this._apiDataProvider, this._localDataProvider);

  @override
  Future<List<MovieItem>> getList(String search) async {
    try {
      List<MovieItem> movieList;
      if (RamStorage().hasNetwork()) {
        movieList = await _apiDataProvider.getList(search);
        if(search.isEmpty) {
          await _localDataProvider.createOrUpdateList(movieList);
        }
      } else {
        movieList = await _localDataProvider.getList(search);
      }
      return movieList;
    } catch (err) {
      return Future.error(err);
    }
  }
}
