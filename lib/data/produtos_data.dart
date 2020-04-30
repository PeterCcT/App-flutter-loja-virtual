import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutosData {
  String id;
  String categorie;
  String descricao;
  String title;
  double preco;
  List image;
  List size;

  ProdutosData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    descricao = snapshot.data['descricao'];
    preco = double.parse(snapshot.data['preco'].toString());
    image = snapshot.data['images'];
    size = snapshot.data['tamanhos'];
  }
}
