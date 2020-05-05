import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Japa Clothing',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red[400],
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
