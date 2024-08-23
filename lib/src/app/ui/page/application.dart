import 'package:flutter/material.dart';
import 'package:movie_box/src/app/ui/page/splash/splash_screen.dart';

class ApplicationClass extends StatelessWidget {
  const ApplicationClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
