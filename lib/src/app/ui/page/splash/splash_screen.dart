import 'package:flutter/material.dart';
import 'package:movie_box/res/colors.dart';
import 'package:movie_box/res/dimens.dart';
import 'package:movie_box/res/texts.dart';
import 'package:movie_box/src/app/ui/page/home/home_screen.dart';
import 'package:movie_box/src/app/ui/widget/base/base_stateful_widget.dart';
import 'package:movie_box/src/app/ui/widget/progress/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulState<SplashScreen> {
  late BuildContext context;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      navigate(const HomeScreen(), replacement: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: UiColors.amber_600,
      body: Column(
        children: [
          SizedBox(
            height: Dimens.padding_xlarge,
          ),
          Expanded(
              child: Center(
            child: Text(
              Texts.appName,
              style: TextStyle(
                  color: UiColors.blueGray_900,
                  fontSize: Dimens.font_size_xlarge,
                  fontWeight: FontWeight.bold),
            ),
          )),
          const LoadingWidget(),
          Padding(
            padding: EdgeInsets.all(Dimens.padding_medium),
            child: Text(Texts.appVersion,
                style: TextStyle(
                    color: UiColors.blueGray_900,
                    fontSize: Dimens.font_size_small,
                    fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }
}
