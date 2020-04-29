import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

class Home extends StatelessWidget {
final _controladorPg = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controladorPg,
      physics: NeverScrollableScrollPhysics(),
      reverse: false,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
         Scaffold(
           body: HomeTab(),
           drawer: CustomDrawer(_controladorPg),
         ),
      ],
    );
  }
}