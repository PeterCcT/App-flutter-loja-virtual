import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/data/produtos_data.dart';

class Produtoscarrinho {
  String cartId;
  String categorie;
  String produtoid;
  int quantidade;
  String tamanho;
  ProdutosData dadosProduto;

  Produtoscarrinho.fromDocument(DocumentSnapshot document) {
    cartId = document.documentID;
    categorie = document.data['categoria'];
    produtoid = document.data['produtoId'];
    quantidade = document.data['quantidade'];
    tamanho = document.data['tamanho'];
  }

  Map<String, dynamic> toMap() {
    return {
      'categoria': categorie,
      'produtoId': produtoid,
      'quantidade': quantidade,
      'tamanho': tamanho,
      'produto': dadosProduto.toResumeMap()
    };
  }
}
