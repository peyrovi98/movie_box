import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_box/src/data/datasource/movie/movie_data_provider.dart';
import 'package:movie_box/src/data/repository/movie/list/movie_list_repository_impl.dart';
import 'package:movie_box/src/data/source/ram/ram_storage.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'movie_list_repository_impl_test.mocks.dart';

@GenerateMocks([MovieListDataProvider])
void main() {
  late MovieListDataProvider apiDataProvider, localDataProvider;
  late MovieListRepositoryImpl repository;

  setUpAll(() {
    apiDataProvider = MockMovieListDataProvider();
    localDataProvider = MockMovieListDataProvider();
    repository = MovieListRepositoryImpl(apiDataProvider, localDataProvider);
  });

  group("get movie list from data source", () {
    test(
        "If user has network, when call getList method, data provide from network.",
        () async {
      RamStorage().setHasNetwork(true);
      String query = "";
      var response = List<MovieItem>.empty();

      when(apiDataProvider.getList(query))
          .thenAnswer((realInvocation) => Future(() => response));

      await repository.getList(query);

      verify(apiDataProvider.getList(query)).called(1);
      verify(localDataProvider.createOrUpdateList(response)).called(1);
      verifyNever(localDataProvider.getList(query));
    });

    test(
        "If user has offline, when call getList method, data provide from sqlite database.",
        () async {
      RamStorage().setHasNetwork(false);
      String query = "";
      var response = List<MovieItem>.empty();

      when(localDataProvider.getList(query))
          .thenAnswer((realInvocation) => Future(() => response));

      await repository.getList(query);

      verify(localDataProvider.getList(query)).called(1);
      verifyNever(apiDataProvider.getList(query));
    });
  });
}
