import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/src/app/logic/base/page_status.dart';
import 'package:movie_box/src/app/logic/movie/list/movie_list_page_data.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/usecase/movei/list/movie_list_usecase.dart';

part 'movie_list_event.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListPageData> {
  final MovieListUseCase movieListUseCase;

  MovieListBloc({required this.movieListUseCase})
      : super(MovieListPageData(status: PageStatus.initial)) {
    on<MovieListEvent>(_getMovieList);
  }

  Future<void> _getMovieList(
      MovieListEvent event, Emitter<MovieListPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));
    try {
      List<MovieItem> movieList =
          await movieListUseCase.invoke(search: event.query);
      print("success, Size: ${movieList.length}");
      emit.call(
          state.copyWith(movieList: movieList, status: PageStatus.success));
    } catch (error) {
      print("error, message: ${error.toString()}");
      emit.call(state.copyWith(
          message: error.toString(), status: PageStatus.failure));
    }
  }
}
