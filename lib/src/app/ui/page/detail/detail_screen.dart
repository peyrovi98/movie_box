import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_box/res/colors.dart';
import 'package:movie_box/res/dimens.dart';
import 'package:movie_box/src/app/ui/widget/custom/toolbar/page_toolbar.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/model/movie/movie_static.dart';

class DetailScreen extends StatefulWidget {
  final MovieItem movieItem;

  const DetailScreen({required this.movieItem, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.blueGray_900,
      appBar: PageToolbar(
        textTitle: widget.movieItem.title,
        isShowBackBtn: true,
      ),
      body: _contentPage(),
    );
  }

  Widget _contentPage() {
    return SingleChildScrollView(
      child: Column(children: [
        Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(0), right: Radius.circular(0)),
              child: CachedNetworkImage(
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
                imageUrl: widget.movieItem.poster,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    Image.asset('images/default_poster.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('images/default_poster.png'),
              ),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.play_circle_outline,
              size: 60,
              color: Colors.white60,
            ),
            // onTap: () => launch(_getXController.detail.value.trailer),
          )
        ]),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            children: [
              title(filedGenre),
              desc(widget.movieItem.genre.join(',')),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Dimens.padding_medium,
              right: Dimens.padding_medium,
              top: Dimens.padding_small),
          child: Row(
            children: [
              title(filedYear),
              desc(widget.movieItem.year.toString()),
              title(filedRuntime),
              desc(widget.movieItem.runtime.toString()),
              title(filedRating),
              desc(widget.movieItem.rating.toString()),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(Dimens.padding_medium),
            child: title(widget.movieItem.plot))
      ]),
    );
  }

  Widget title(String title) {
    return Text(
      title,
      textAlign: TextAlign.justify,
      style: const TextStyle(color: Colors.white38),
    );
  }

  Widget desc(String desc) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          desc,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: UiColors.white),
        ),
      ),
    );
  }
}
