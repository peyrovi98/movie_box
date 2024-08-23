import 'package:flutter/material.dart';
import 'package:movie_box/res/colors.dart';
import 'package:movie_box/res/dimens.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  final GlobalKey<ScaffoldState> pageKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void showSnack(String text) {
    if (text.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: UiColors.amber_900,
      elevation: 32,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.radius_medium),
            topRight: Radius.circular(Dimens.radius_medium),
          )),
      content: Text(
        text,
        softWrap: true,
        style: TextStyle(fontSize: Dimens.box_size_medium, color: UiColors.blueGray_900),
      ),
    ));
  }

  void navigate(Widget screen, {bool replacement = false}) {
    if(replacement) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return screen;
            },
          )
      );
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return screen;
            },
          )
      );
    }
  }
}
