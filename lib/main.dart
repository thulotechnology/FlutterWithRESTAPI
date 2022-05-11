import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app_with_api/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "Quotes App",
        home: HomePage(),
      ),
    );
  }
}
