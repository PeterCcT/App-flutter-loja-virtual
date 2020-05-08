import 'package:flutter/material.dart';
import 'package:lojavirtual/models/carrinho_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/screens/pedido_screen.dart';
import 'package:lojavirtual/tiles/carrinho_tile.dart';
import 'package:lojavirtual/widgets/carrinho_price.dart';
import 'package:lojavirtual/widgets/desconto_card.dart';
import 'package:lojavirtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CarrinhoModel>(
                builder: (context, child, model) {
              int p = model.produtos.length;
              return Text(
                '${p ?? 0} ${p == 1 ? 'Item' : 'Itens'}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              );
            }),
          ),
        ],
      ),
      body: ScopedModelDescendant<CarrinhoModel>(
        builder: (context, child, model) {
          if (model.loading && UserModel.of(context).logado()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).logado()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Faça o login para adicionar itens ao carrinho',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    child: Text('Entrar', style: TextStyle(fontSize: 18)),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (model.produtos == null || model.produtos.length == 0) {
            return Center(
              child: Text(
                'Nenhum produto encontrado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.produtos.map(
                    (item) {
                      return CarrinhoTile(item);
                    },
                  ).toList(),
                ),
                DescontoCard(),
                ShipCard(),
                CarrinhoPrice(() async {
                  String pedidoID = await model.realizarPedido();
                  if (pedidoID != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PedidoScreen(pedidoID),
                      ),
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
