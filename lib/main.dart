import 'package:apwen/app_theme.dart';
import 'package:apwen/route/route_generator.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
      onUnknownRoute: RouteGenerator.errorPage,
      title: 'APWEN',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
    );
  }
}
