import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japa Clothing',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[400],
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
