import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/widgets/carrinho_button.dart';
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
          floatingActionButton: CarrinhoButton(),
          drawer: CustomDrawer(_controladorPg),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          body: CategoriesOfTabs(),
          floatingActionButton: CarrinhoButton(),
          drawer: CustomDrawer(_controladorPg),
        ),
      ],
    );
  }
}
