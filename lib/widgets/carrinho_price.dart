import 'package:flutter/material.dart';
import 'package:lojavirtual/models/carrinho_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoPrice extends StatelessWidget {
  final VoidCallback buy;
  CarrinhoPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(10),
        child: ScopedModelDescendant<CarrinhoModel>(
          builder: (context, child, model) {
            double price = model.getProdutosPrice();
            double desconto = model.getDescontoPrice();
            double ship = model.getEntregaPrice();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Resumo do pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Subtotal'),
                    Text('R\$ ${price.toStringAsFixed(2)}'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Desconto'),
                    Text('${desconto.toStringAsFixed(2)}%'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Entrega'),
                    Text('R\$ ${ship.toStringAsFixed(2)}'),
                  ],
                ),
                Divider(),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'R\$ ${(price + ship - desconto).toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                RaisedButton(
                  onPressed: buy,
                  child: Text('Finalizar pedido'),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
