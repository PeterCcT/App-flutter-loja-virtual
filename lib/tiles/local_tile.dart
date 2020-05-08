import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalTile extends StatelessWidget {
  final DocumentSnapshot local;
  LocalTile(this.local);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Image.network(
                local.data['image'],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    local.data['title'],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(local.data['endereco'], textAlign: TextAlign.start),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    launch(
                        'https://www.google.com/maps/search/?api=1&query=${local.data['lat']},${local.data['long']}');
                  },
                  child: Text('Ver no mapa'),
                  padding: EdgeInsets.zero,
                ),
                FlatButton(
                  onPressed: () {
                    launch('tel:${local.data['telefone']}');
                  },
                  child: Text('Ligar'),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
