import 'package:ai_radio/pages/home_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterdemo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    );
  }
}
