import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoriesTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data['icon']),
      ),
      title: Text(snapshot.data['title']),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
