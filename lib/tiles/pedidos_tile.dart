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
}
