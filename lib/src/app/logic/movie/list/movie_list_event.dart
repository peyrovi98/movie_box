part of 'movie_list_bloc.dart';

@immutable
class MovieListEvent {
  String query;

  MovieListEvent({this.query = ""});
}
