import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_box/res/colors.dart';
import 'package:movie_box/res/dimens.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';

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
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Dimens.box_size_medium,
            height: Dimens.box_size_medium,
            child: avatarImage(item.poster),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dimens.padding_smallest,
                  horizontal: Dimens.padding_small),
              child: Column(
                children: [
                  detailsItem("name", "genre", UiColors.blueGray_900),
                  detailsItem(
                      item.title,
                      item.actors.isNotEmpty ? item.actors[0] : "-",
                      UiColors.white),
                ],
              ),
            ),
          )
        ],
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
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
      child: CachedNetworkImage(
        imageUrl: image,
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
