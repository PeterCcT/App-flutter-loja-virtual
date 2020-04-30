import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/produtos_screen.dart';

class CategoriesTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoriesTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoriesScreen(snapshot),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(snapshot.data['icon']),
        ),
        title: Text(snapshot.data['title']),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
