import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final primarycolor = Theme.of(context).primaryColor;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cadastrar'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.loading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                TextFormField(
                  controller: _nomeController,
                  validator: (text) {
                    if (text.isEmpty) return 'Nome invalido';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nome completo',
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: _enderController,
                  validator: (text) {
                    if (text.isEmpty) return 'Endereço invalido';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Endereço',
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return 'Email invalido';
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: _senhaController,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Senha invalida';
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        'nome': _nomeController.text,
                        'email': _emailController.text,
                        'endereco': _enderController.text,
                      };
                      model.cadastro(
                          userData: userData,
                          senha: _senhaController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    }
                    _formKey.currentState.save();
                  },
                  child: Text(
                    'Criar conta',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  color: primarycolor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Usuário criado com sucesso',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pop(context);
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao criar usuário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
