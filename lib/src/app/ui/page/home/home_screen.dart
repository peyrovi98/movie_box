import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/res/colors.dart';
import 'package:movie_box/res/dimens.dart';
import 'package:movie_box/res/texts.dart';
import 'package:movie_box/src/app/di/di.dart';
import 'package:movie_box/src/app/logic/base/page_status.dart';
import 'package:movie_box/src/app/logic/movie/list/movie_list_bloc.dart';
import 'package:movie_box/src/app/logic/movie/list/movie_list_page_data.dart';
import 'package:movie_box/src/app/ui/page/detail/detail_screen.dart';
import 'package:movie_box/src/app/ui/widget/base/base_stateful_widget.dart';
import 'package:movie_box/src/app/ui/widget/list/list_item_widget.dart';
import 'package:movie_box/src/app/ui/widget/progress/loading_widget.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulState<HomeScreen> {
  final MovieListBloc _movieListBloc =
      MovieListBloc(movieListUseCase: DI().getMovieListUseCase());
  String _query = "";

  @override
  Widget build(BuildContext context) {
    _movieListBloc.add(MovieListEvent());
    return BlocProvider<MovieListBloc>(
      create: (BuildContext context) => _movieListBloc,
      child: Scaffold(
        backgroundColor: UiColors.blueGray_900,
        body: Column(
          children: [
            SizedBox(
              height: Dimens.padding_large,
            ),
            searchBar(),
            Expanded(child: _moviePage(context)),
          ],
        ),
      ),
    );
  }

  Card searchBar() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.radius_medium))),
      margin: EdgeInsets.symmetric(
          horizontal: Dimens.padding_small, vertical: Dimens.padding_smallest),
      color: UiColors.white,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimens.padding_small,
            vertical: Dimens.padding_smallest),
        child: TextField(
          style: const TextStyle(
            color: UiColors.blueGray_900,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            _query = value;
            _movieListBloc.add(MovieListEvent(query: _query));
          },
          cursorColor: Colors.blueGrey,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: UiColors.amber_700,
            ),
            icon: Icon(
              Icons.search,
              color: UiColors.amber_700,
            ),
            hintText: Texts.searchMovie,
          ),
        ),
      ),
    );
  }

  Widget _moviePage(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListPageData>(
      buildWhen: (previous, current) {
        return true;
      },
      bloc: _movieListBloc,
      builder: (context, state) {
        return Container(child: _viewChooser(state));
      },
    );
  }

  _viewChooser(MovieListPageData state) {
    return switch (state.pageStatus) {
      PageStatus.success => _movieListWidget(context, state.movieList),
      PageStatus.failure => _viewError(state.message),
      _ => const LoadingWidget(
          color: UiColors.amber_700,
        ),
    };
  }

  Widget _movieListWidget(BuildContext context, List<MovieItem> movieList) {
    return ListView.builder(
      padding: EdgeInsets.only(top: Dimens.padding_smaller),
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        return ListItemWidget(
          movieItem: movieList[index],
          onPressed: (movieItem) {
            navigate( DetailScreen(movieItem: movieItem,), replacement: false);
          },
        );
      },
      controller: ScrollController(),
    );
  }

  Widget _viewError(String message) {
    showSnack(message);
    return Center(
      child: InkWell(
        child: Icon(
          Icons.refresh,
          size: Dimens.box_size_small,
          color: UiColors.amber_700,
        ),
        onTap: () {
          _movieListBloc.add(MovieListEvent(query: _query));
        },
      ),
    );
  }
}
