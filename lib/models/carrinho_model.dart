import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/carrinho_data.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model {
  UserModel user;
  List<Produtoscarrinho> produtos = [];
  bool loading = false;
  String cupomCode;
  int descontoPercent = 0;
  CarrinhoModel(this.user) {
    if (user.logado()) {
      _loadCarrinho();
    }
  }
  static CarrinhoModel of(BuildContext context) =>
      ScopedModel.of<CarrinhoModel>(context);

  void addProdutoCarrinho(Produtoscarrinho item) {
    produtos.add(item);
    Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Carrinho')
        .add(
          item.toMap(),
        )
        .then((doc) => item.cartId = doc.documentID);
    notifyListeners();
  }

  void removeProdutoCarrinho(Produtoscarrinho item) {
    Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Carrinho')
        .document(item.cartId)
        .delete();
    produtos.remove(item);
    notifyListeners();
  }

  void decProduto(Produtoscarrinho produto) {
    produto.quantidade--;
    Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Carrinho')
        .document(produto.cartId)
        .updateData(produto.toMap());
    notifyListeners();
  }

  void incProduto(Produtoscarrinho produto) {
    produto.quantidade++;
    Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Carrinho')
        .document(produto.cartId)
        .updateData(produto.toMap());
    notifyListeners();
  }

  void _loadCarrinho() async {
    QuerySnapshot query = await Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Carrinho')
        .getDocuments();
    produtos =
        query.documents.map((e) => Produtoscarrinho.fromDocument(e)).toList();
    notifyListeners();
  }

  void setCupom(String cupom, int desconto) {
    cupomCode = cupom;
    descontoPercent = desconto;
  }
}
