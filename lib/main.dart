import 'package:flutter/material.dart';
import 'package:mini_game/mini_game/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Game',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfffff3e0),
        primaryColor: const Color(0xfff57f08),
      ),
      home: const Home(),
    );
  }
}
