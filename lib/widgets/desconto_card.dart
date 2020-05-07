import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/carrinho_model.dart';

class DescontoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        leading: Icon(Icons.attach_money),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom',
              ),
              initialValue: CarrinhoModel.of(context).cupomCode ?? '',
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection('Cupom')
                    .document(text)
                    .get()
                    .then(
                  (value) {
                    if (value.data != null) {
                      CarrinhoModel.of(context)
                          .setCupom(text, value.data['porcento']);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Desconto de ${value.data['porcento']}% aplicado',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      );
                    } else {
                      // CarrinhoModel.of(context).setCupom(null, 0);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Esse cupom não existe',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
