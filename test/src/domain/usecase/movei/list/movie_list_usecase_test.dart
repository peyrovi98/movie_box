import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/repository/movie/list/movie_list_repository.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';

import '../../../../fake_items.dart';
import 'movie_list_usecase_test.mocks.dart';

@GenerateMocks([MovieListRepository])
void main() {
  late MovieListUseCase usecase;
  late MockMovieListRepository repository;
  late Faker faker;

  setUpAll(() async {
    repository = MockMovieListRepository();
    usecase = MovieListUseCase(repository);
    faker = Faker();
  });

  group("movie list usCase invoke", () {
    test("When call invoke then call getList on repository", () async {
      when(repository.getList(any))
          .thenAnswer((realInvocation) => Future.value([]));
      usecase.invoke();
      verify(repository.getList(any)).called(1);
    });

    test("When call invoke then data returns true", () async {
      String query = faker.lorem.sentence();
      var items = List<MovieItem>.empty(growable: true);
      items.add(getFakeMovieItem());
      items.add(getFakeMovieItem());
      items.add(getFakeMovieItem());
      items.add(getFakeMovieItem());
      items.add(getFakeMovieItem());

      when(repository.getList(query))
          .thenAnswer((realInvocation) => Future.value(items));
      var retrieveItems = await usecase.invoke(search: query);

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
      verify(repository.getList(query)).called(1);
    });
  });
}
