import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool loading = false;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadUserAtual();
  }

  void cadastro(
      {@required Map<String, dynamic> userData,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    loading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: senha)
        .asStream()
        .listen(
      (user) async {
        firebaseUser = user;
        await _saveUserData(userData);
        onSuccess();
        loading = false;
        notifyListeners();
      },
      onError: (Object e) {
        onFail();
        loading = false;
        notifyListeners();
      },
    );

/*     _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: senha)
        .then((FirebaseUser user) async {
      firebaseUser = user;
      await _saveUserData(userData);
      onSuccess();
      loading = false;
      notifyListeners();
    }).catchError(
      (e) {
        onFail();
        loading = false;
        notifyListeners();
      },
    ); */
  }

  void login(
      {@required String email,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    loading = true;
    notifyListeners();
    _auth.signInWithEmailAndPassword(email: email, password: senha).then(
      (user) async {
        firebaseUser = user;
        await _loadUserAtual();
        onSuccess();
        loading = false;
        notifyListeners();
      },
    ).catchError(
      (e) {
        onFail();
        loading = false;
        notifyListeners();
      },
    );
  }

  void sair() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void esqueciSenha() {}

  bool logado() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection('Users')
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadUserAtual() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userData['nome'] == null) {
        DocumentSnapshot user = await Firestore.instance
            .collection('user')
            .document(firebaseUser.uid)
            .get();
        userData = user.data;
      }
    }
    notifyListeners();
  }
}
