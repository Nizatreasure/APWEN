import 'dart:async';

import 'package:apwen/app_theme.dart';
import 'package:apwen/provider.dart';
import 'package:apwen/route/route_generator.dart';
import 'package:apwen/screens/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
      ],
      child: IntermediaryPage(),
    );
  }
}

class IntermediaryPage extends StatefulWidget {
  const IntermediaryPage({Key? key}) : super(key: key);

  @override
  State<IntermediaryPage> createState() => _IntermediaryPageState();
}

class _IntermediaryPageState extends State<IntermediaryPage> {
  late StreamSubscription subscription;
  late ConnectivityProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ConnectivityProvider>(context, listen: false);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        provider.updatedConnectionStatus(false);
      } else {
        provider.updatedConnectionStatus(true);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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
