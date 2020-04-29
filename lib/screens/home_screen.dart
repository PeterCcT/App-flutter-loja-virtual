import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';
import 'package:lojavirtual/tabs/categories_tab.dart';
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
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          body: CategoriesOfTabs(),
          drawer: CustomDrawer(_controladorPg),
        ),
      ],
    );
  }
}
