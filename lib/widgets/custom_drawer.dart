import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _drawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(180, 63, 43, 1),
                /*    Color.fromRGBO(43, 96, 89, 1), */
                Color.fromRGBO(50, 35, 100, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _drawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 18),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "Japa's\nclothes",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Olá!,${model.logado() ? model.userData['nome'] : ''}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!model.logado()) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  } else {
                                    model.sair();
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    !model.logado()
                                        ? 'Entre ou cadastre-se'
                                        : 'Sair',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(100, 100, 255, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile('Início', Icons.home, pageController, 0),
              DrawerTile('Produtos', Icons.card_giftcard, pageController, 1),
              DrawerTile(
                  'Encontre uma loja', Icons.location_on, pageController, 2),
              DrawerTile(
                  'Meus pedidos', Icons.playlist_add_check, pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
