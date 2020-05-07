import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/data/carrinho_data.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model {
  UserModel user;
  List<Produtoscarrinho> produtos = [];
  CarrinhoModel(this.user);

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
}
