import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_box/src/app/logic/base/page_status.dart';
import 'package:movie_box/src/app/logic/movie/list/movie_list_bloc.dart';
import 'package:movie_box/src/app/logic/movie/list/movie_list_page_data.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([MovieListUseCase])
void main() {
  late MovieListBloc createOrUpdateBloc;
  late MovieListUseCase categoryUseCase;
  final Faker faker = Faker();;

  setUp(() {
    EquatableConfig.stringify = true;
    categoryUseCase = MockMovieListUseCase();
    createOrUpdateBloc = MovieListBloc(movieListUseCase: categoryUseCase);
  });

  blocTest<MovieListBloc, MovieListPageData>(
    "request list without query filter and result most be success",
    build: () {
      when(categoryUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value([]);
      });
      return createOrUpdateBloc;
    },
    act: (bloc) => bloc.add(MovieListEvent()),
    expect: () {
      return [
        MovieListPageData(status: PageStatus.loading),
        MovieListPageData(status: PageStatus.success)
      ];
    },
  );

  String query = faker.lorem.sentence();
  blocTest<MovieListBloc, MovieListPageData>(
    "request list with query filter and result most be success",
    build: () {
      when(categoryUseCase.invoke(search: query)).thenAnswer((realInvocation) {
        return Future.value([]);
      });
      return createOrUpdateBloc;
    },
    act: (bloc) => bloc.add(MovieListEvent(query: query)),
    expect: () {
      return [
        MovieListPageData(status: PageStatus.loading),
        MovieListPageData(status: PageStatus.success)
      ];
    },
  );

  blocTest<MovieListBloc, MovieListPageData>(
    "request list without query filter and result most be failure",
    build: () {
      when(categoryUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.error("error");
      });
      return createOrUpdateBloc;
    },
    act: (bloc) => bloc.add(MovieListEvent()),
    expect: () {
      return [
        MovieListPageData(status: PageStatus.loading),
        MovieListPageData(status: PageStatus.failure)
      ];
    },
  );

  tearDown(() {
    createOrUpdateBloc.close();
  });
}
