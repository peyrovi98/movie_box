import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_box/res/colors.dart';
import 'package:movie_box/res/dimens.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';
import 'package:movie_box/src/domain/model/movie/movie_static.dart';

class ListItemWidget extends StatelessWidget {
  final MovieItem movieItem;
  final Function(MovieItem) onPressed;

  const ListItemWidget(
      {super.key, required this.movieItem, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: itemMainList(movieItem),
      onTap: () => onPressed.call(movieItem),
    );
  }

  Widget itemMainList(MovieItem item) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.radius_medium))),
      margin: EdgeInsets.symmetric(
          vertical: Dimens.padding_smaller, horizontal: Dimens.padding_small),
      color: UiColors.amber_700,
      child: SizedBox(
        height: Dimens.box_size_medium,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.box_size_medium,
              height: double.maxFinite,
              child: avatarImage(item.poster),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_small),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _titleWidget(filedTitle),
                    _descriptionWidget(item.title),
                    _titleWidget(filedGenre),
                    _descriptionWidget(item.genre.join(', ')),
                    _titleWidget(filedRating),
                    _descriptionWidget(item.rating.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget(String text) {
    return Text(
      text,
      style: TextStyle(
          color: UiColors.blueGray_900, fontSize: Dimens.font_size_small),
    );
  }

  Widget _descriptionWidget(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: UiColors.white,
        fontSize: Dimens.font_size_small,
      ),
    );
  }

  Widget detailsItem(String s, String t, Color tColor) {
    return Container(
      padding: EdgeInsets.all(Dimens.padding_smallest),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              s,
              style: TextStyle(color: tColor, fontSize: Dimens.font_size_small),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              t,
              style: TextStyle(color: tColor, fontSize: Dimens.font_size_small),
            ),
          ),
        ],
      ),
    );
  }

  Widget avatarImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(Dimens.radius_medium)),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
          padding: EdgeInsets.all(Dimens.padding_large),
          child: const Icon(
            Icons.downloading,
            color: Colors.white10,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white38,
        ),
      ),
    );
  }
}
