import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primarycolor = Theme.of(context).primaryColor;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              'Cadastrar',
              style: TextStyle(fontSize: 15),
            ),
            textColor: Colors.white,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextFormField(
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
              validator: (text) {
                if (text.isEmpty || text.length < 6) return 'Senha invalida';
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
                  _formKey.currentState.save();
                }
              },
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              color: primarycolor,
            ),
          ],
        ),
      ),
    );
  }
}
