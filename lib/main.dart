import 'package:flutter/material.dart';
import 'package:mobile_dtr_prototype/constants/navigation_provider.dart';
import 'package:mobile_dtr_prototype/views/homepage_view.dart';
import 'package:mobile_dtr_prototype/views/login_view.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Add this code to make httpoverrides to the whole project
  HttpOverrides.global = MyHttpOverrides();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        title: 'Mobile DTR Prototype',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            primarySwatch: Colors.blue),
        home: const LoginView(),
        routes: {
          loginRoute: (context) => const LoginView(),
          homePageRoute: (context) => const HomePageView()
        },
      ));
}

//Use this code to prevent HandleHandshake Error
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
