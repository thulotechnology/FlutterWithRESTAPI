import 'package:flutter/material.dart';
import 'package:quotes_app_with_api/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quotes App",
      home: HomePage(),
    );
  }
}
