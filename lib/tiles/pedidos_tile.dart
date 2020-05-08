import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PedidosTile extends StatelessWidget {
  final String pedidoId;
  PedidosTile(this.pedidoId);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Pedidos')
              .document(pedidoId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data['Status'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Código do pedido: ${snapshot.data.documentID}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    _buildProdutoTexto(snapshot.data),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Status do pedido',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle('1', 'Preparação', status, 1),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('2', 'Transporte', status, 2),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('3', 'Entrega', status, 3),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProdutoTexto(DocumentSnapshot snapshot) {
    String text = 'Descrição\n';
    for (LinkedHashMap p in snapshot.data['Produtos']) {
      text +=
          '${p['quantidade']} x ${p['produto']['title']} (R\$ ${p['produto']['preco'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R\$ ${snapshot.data['Total'].toStringAsFixed(2)}';
    return text;
  }

  Widget _buildCircle(
      String title, String subTitle, int status, int thisStatus) {
    Color backcolor;
    Widget child;

    if (status < thisStatus) {
      backcolor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backcolor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backcolor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backcolor,
          child: child,
        ),
        Text(subTitle),
      ],
    );
  }
}
