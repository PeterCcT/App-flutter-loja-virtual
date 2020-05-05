import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool loading = false;

  void cadastro(
      {@required Map<String, dynamic> userData,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    loading = true;
    notifyListeners();
    await _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: senha)
        .then((user) async {
      firebaseUser = user as FirebaseUser;
      await _saveUserData(userData);
      onSuccess();
      loading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      loading = false;
      notifyListeners();
    });
  }

  void login() async {
    loading = true;
    notifyListeners();
  }

  void esqueciSenha() {}

  bool logado() {}

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection('Users')
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
