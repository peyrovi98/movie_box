import 'package:faker/faker.dart';
import 'package:movie_box/src/data/datasource/movie/movie_local_data_provider.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:test/test.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../fake_items.dart';

void main() {
  late MovieListLocalDataProvider dataProvider;
  sqfliteFfiInit();

  setUpAll(() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    dataProvider = MovieListLocalDataProvider(db);
  });

  test('Insert Items', () async {
    var items = List<MovieItem>.empty(growable: true);
    items.add(getFakeMovieItem());
    items.add(getFakeMovieItem());
    items.add(getFakeMovieItem());

    await dataProvider.createOrUpdateList(items);
    var retrieveItems = await dataProvider.getList("");

    expect(retrieveItems, isNotNull);
    expect(retrieveItems.length, items.length);
    for(int index = 0; index < retrieveItems.length; index++) {
      expect(retrieveItems[index].id, items[index].id);
      expect(retrieveItems[index].rating, items[index].rating);
      expect(retrieveItems[index].genre, items[index].genre);
      expect(retrieveItems[index].plot, items[index].plot);
      expect(retrieveItems[index].runtime, items[index].runtime);
      expect(retrieveItems[index].year, items[index].year);
      expect(retrieveItems[index].director, items[index].director);
      expect(retrieveItems[index].poster, items[index].poster);
      expect(retrieveItems[index].title, items[index].title);
      expect(retrieveItems[index].actors, items[index].actors);
      expect(retrieveItems[index].awards, items[index].awards);
      expect(retrieveItems[index].boxOffice, items[index].boxOffice);
      expect(retrieveItems[index].country, items[index].country);
      expect(retrieveItems[index].language, items[index].language);
      expect(retrieveItems[index].production, items[index].production);
      expect(retrieveItems[index].trailer, items[index].trailer);
      expect(retrieveItems[index].website, items[index].website);
    }
  });

  tearDown(() {
    dataProvider.clear();
  });
}