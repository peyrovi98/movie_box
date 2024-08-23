import 'package:flutter/material.dart';
import 'package:movie_box/src/app/di/di.dart';
import 'package:movie_box/src/app/ui/page/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI().initialize();
  await DI().getCheckConnectionUseCase().invoke();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ApplicationClass(),
  ));
}