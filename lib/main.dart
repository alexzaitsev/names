import 'package:flutter/material.dart';
import 'screen/home.dart';

void main() {
  String googleScriptURL = const String.fromEnvironment('googleScriptURL');
  runApp(MyApp(googleScriptURL: googleScriptURL));
}

class MyApp extends StatelessWidget {
  final String googleScriptURL;

  const MyApp({super.key, required this.googleScriptURL});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Українські імена',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(googleScriptURL: googleScriptURL),
    );
  }
}
