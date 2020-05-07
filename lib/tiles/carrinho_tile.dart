import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/carrinho_data.dart';
import 'package:lojavirtual/data/produtos_data.dart';
import 'package:lojavirtual/models/carrinho_model.dart';

class CarrinhoTile extends StatelessWidget {
  final Produtoscarrinho produtoscarrinho;
  CarrinhoTile(this.produtoscarrinho);
  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CarrinhoModel.of(context).updatePrices();
      return Row(
        children: <Widget>[
          Container(
            width: 130,
            child: Image.network(produtoscarrinho.dadosProduto.image[0]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    produtoscarrinho.dadosProduto.title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Tamanho ${produtoscarrinho.tamanho}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${produtoscarrinho.dadosProduto.preco.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: produtoscarrinho.quantidade > 1
                            ? () {
                                CarrinhoModel.of(context)
                                    .decProduto(produtoscarrinho);
                              }
                            : null,
                      ),
                      Text(produtoscarrinho.quantidade.toString()),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.green[500],
                        ),
                        onPressed: () {
                          CarrinhoModel.of(context)
                              .incProduto(produtoscarrinho);
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          CarrinhoModel.of(context)
                              .removeProdutoCarrinho(produtoscarrinho);
                        },
                        child: Text(
                          'Remover',
                        ),
                        textColor: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: produtoscarrinho.dadosProduto == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('produtos')
                  .document(produtoscarrinho.categorie)
                  .collection('itens')
                  .document(produtoscarrinho.produtoid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  produtoscarrinho.dadosProduto =
                      ProdutosData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
