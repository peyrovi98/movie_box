import 'package:movie_box/res/texts.dart';
import 'package:movie_box/src/app/logic/base/page_status.dart';
import 'package:movie_box/src/app/logic/base/parent_page_data.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';

class MovieListPageData extends ParentPageData {
  List<MovieItem> movieList;
  String message;

  MovieListPageData({this.movieList = const [], this.message = "", required PageStatus status})
      : super(pageStatus: status);

  MovieListPageData copyWith({
    PageStatus? status,
    List<MovieItem>? movieList,
    String? message,
  }) {
    return MovieListPageData(
      movieList: movieList ?? this.movieList,
      message: message ?? Texts.noConnection,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, movieList];
}
