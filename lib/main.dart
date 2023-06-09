import 'package:flutter/material.dart';
import 'package:instinct_app/pages/home_page.dart';
import 'package:instinct_app/pages/login.dart';
import 'package:instinct_app/pages/vendor1_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instinct App',

      theme: ThemeData(
        primarySwatch: Colors.purple,
          fontFamily: 'SF Pro'
      ),
      home: LoginPage(),
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("habfio")),
    );
  }
}
