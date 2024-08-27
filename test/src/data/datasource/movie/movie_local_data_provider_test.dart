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
    for (int index = 0; index < retrieveItems.length; index++) {
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

  test('When an item is entered twice, finally one item must be saved.',
      () async {
        var items = List<MovieItem>.empty(growable: true);
        var item = getFakeMovieItem();
        items.add(item);
        items.add(item);
    await dataProvider.createOrUpdateList(items);
    var retrieveItems = await dataProvider.getList("");
    expect(retrieveItems.length, 1);
  });

  test('When a number of items are entered into the database and then clear the database, all items are expected to be deleted.',
          () async {
        var items = List<MovieItem>.empty(growable: true);
        items.add(getFakeMovieItem());
        items.add(getFakeMovieItem());
        items.add(getFakeMovieItem());
        await dataProvider.createOrUpdateList(items);
        await dataProvider.clear();
        var retrieveItems = await dataProvider.getList("");
        expect(retrieveItems.length, 0);
      });

  test('When an item is entered twice, finally one item must be saved.',
          () async {
        var items = List<MovieItem>.empty(growable: true);
        items.add(getFakeMovieItem());
        items.add(getFakeMovieItem());
        items[1].id = items[0].id;

        await dataProvider.createOrUpdateList(items);
        var retrieveItems = await dataProvider.getList("");

        expect(retrieveItems.length, 1);

        expect(retrieveItems[0].title, isNot(items[0].title));
        expect(retrieveItems[0].rating, isNot(items[0].rating));
        expect(retrieveItems[0].genre, isNot(items[0].genre));
        expect(retrieveItems[0].plot, isNot(items[0].plot));
        expect(retrieveItems[0].runtime, isNot(items[0].runtime));
        expect(retrieveItems[0].year, isNot(items[0].year));
        expect(retrieveItems[0].director, isNot(items[0].director));
        expect(retrieveItems[0].poster, isNot(items[0].poster));
        expect(retrieveItems[0].title, isNot(items[0].title));
        expect(retrieveItems[0].actors, isNot(items[0].actors));
        expect(retrieveItems[0].awards, isNot(items[0].awards));
        expect(retrieveItems[0].boxOffice, isNot(items[0].boxOffice));
        expect(retrieveItems[0].country, isNot(items[0].country));
        expect(retrieveItems[0].language, isNot(items[0].language));
        expect(retrieveItems[0].production, isNot(items[0].production));
        expect(retrieveItems[0].trailer, isNot(items[0].trailer));
        expect(retrieveItems[0].website, isNot(items[0].website));

        expect(retrieveItems[0].title, items[1].title);
        expect(retrieveItems[0].rating, items[1].rating);
        expect(retrieveItems[0].genre, items[1].genre);
        expect(retrieveItems[0].plot, items[1].plot);
        expect(retrieveItems[0].runtime, items[1].runtime);
        expect(retrieveItems[0].year, items[1].year);
        expect(retrieveItems[0].director, items[1].director);
        expect(retrieveItems[0].poster, items[1].poster);
        expect(retrieveItems[0].title, items[1].title);
        expect(retrieveItems[0].actors, items[1].actors);
        expect(retrieveItems[0].awards, items[1].awards);
        expect(retrieveItems[0].boxOffice, items[1].boxOffice);
        expect(retrieveItems[0].country, items[1].country);
        expect(retrieveItems[0].language, items[1].language);
        expect(retrieveItems[0].production, items[1].production);
        expect(retrieveItems[0].trailer, items[1].trailer);
        expect(retrieveItems[0].website, items[1].website);
      });

  tearDown(() {
    dataProvider.clear();
  });
}
