import 'package:movie_box/src/data/datasource/movie/movie_data_provider.dart';
import 'package:movie_box/src/data/source/server/api_endpoint.dart';
import 'package:movie_box/src/data/source/server/web_service.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';

class MovieListApiDataProvider implements MovieListDataProvider {
  final WebService _webService;

  MovieListApiDataProvider(this._webService);

  @override
  Future<void> createOrUpdate(MovieItem movieItem) {
    // TODO: implement createOrUpdate
    throw UnimplementedError();
  }

  @override
  Future<void> createOrUpdateList(List<MovieItem> movieList) {
    // TODO: implement createOrUpdateList
    throw UnimplementedError();
  }

  @override
  Future<List<MovieItem>> getList(String search) async {
      var result =
      await _webService.callApi(MethodType.GET, search.isEmpty ? ApiEndpoint.movieList : ApiEndpoint.searchMovieList(search));
      List<MovieItem> movieList = List.empty(growable: true);
      if (result.status) {
        for (var jsonObject in result.data) {
          movieList.add(MovieItem.fromJson(jsonObject));
        }
        return movieList;
      }
      return Future.error(result.message);
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }
}
