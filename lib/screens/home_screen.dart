import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';


class Home extends StatelessWidget {
final _controladorPg = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controladorPg,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: <Widget>[
         HomeTab(),
      ],
    );
  }
}