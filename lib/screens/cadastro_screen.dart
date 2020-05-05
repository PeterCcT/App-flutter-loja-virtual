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
  @override
  Widget build(BuildContext context) {
    final primarycolor = Theme.of(context).primaryColor;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 15),
              ),
              textColor: Colors.white,
            )
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.loading)
            return Center(
              child: CircularProgressIndicator(),
            );
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                TextFormField(
                  controller: _nomeController,
                  validator: (text) {
                    if (text.isEmpty) return 'Nome invalido';
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
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        color: primarycolor,
                      ),
                    ),
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
        }));
  }

  void _onSuccess() {}
  void _onFail() {}
}
