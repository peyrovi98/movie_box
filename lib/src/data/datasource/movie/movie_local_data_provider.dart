import 'package:movie_box/src/data/datasource/movie/movie_data_provider.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/model/movie/movie_static.dart';
import 'package:sqflite/sqlite_api.dart';

class MovieListLocalDataProvider implements MovieListDataProvider {
  final Database _database;
  final String tableName = "Movies";

  MovieListLocalDataProvider(this._database) {
    _database.execute(
        "create table if not exists $tableName ($filedId TEXT PRIMARY KEY, "
        "$filedTitle TEXT, $filedYear INTEGER, $filedGenre TEXT, $filedRating INTEGER, "
        "$filedDirector TEXT, $filedActors TEXT, $filedPlot TEXT, $filedPoster TEXT, $filedTrailer TEXT, "
        "$filedRuntime INTEGER, $filedAwards TEXT, $filedCountry TEXT, $filedLanguage TEXT, $filedBoxOffice TEXT, "
        "$filedProduction TEXT,$filedWebsite TEXT"
        " )");
  }

  @override
  Future<void> createOrUpdateList(List<MovieItem> movieList) async {
    for(var movieItem in movieList){
      await createOrUpdate(movieItem);
    }
  }

  @override
  Future<void> createOrUpdate(MovieItem movieItem) async {
    _database.insert(tableName, movieItem.toJson());
  }

  @override
  Future<List<MovieItem>> getList(String search) async {
    List<MovieItem> movieList = List.empty(growable: true);
    List<Map> jsonArray = await _database.query(tableName);
    for (var jsonObject in jsonArray) {
      movieList.add(MovieItem.fromJson(jsonObject));
    }
    return movieList;
  }

  @override
  Future<void> clear() async {
    await _database.delete(tableName);
  }
}
