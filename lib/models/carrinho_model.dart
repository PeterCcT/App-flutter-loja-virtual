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

  double getProdutosPrice() {
    double price = 0.0;
    for (Produtoscarrinho c in produtos) {
      if (c.dadosProduto != null) {
        price += c.quantidade * c.dadosProduto.preco;
      }
    }
    return price;
  }

  double getEntregaPrice() {
    return 9.99;
  }

  double getDescontoPrice() {
    return (getProdutosPrice() * descontoPercent) / 100;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String> realizarPedido() async {
    if (produtos.length == 0) return null;
    loading = true;
    notifyListeners();
    double preco = getProdutosPrice();
    double entrega = getEntregaPrice();
    double desconto = getDescontoPrice();

    DocumentReference refPedido =
        await Firestore.instance.collection('Pedidos').add({
      'ClienteId': user.firebaseUser.uid,
      'Produtos': produtos.map((e) => e.toMap()).toList(),
      'Entrega': entrega,
      'ProdutosPreco': preco,
      'Desconto': desconto,
      'Total': preco - desconto + entrega,
      'Status': 1
    });
    await Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Pedidos')
        .document(refPedido.documentID)
        .setData({'PedidoID': refPedido.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection('Users')
        .document(user.firebaseUser.uid)
        .collection('Carrinho')
        .getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    produtos.clear();
    cupomCode = null;
    descontoPercent = 0;
    loading = false;
    notifyListeners();

    return refPedido.documentID;
  }
}
