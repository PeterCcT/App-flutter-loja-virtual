import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/categories_tile.dart';

class CategoriesOfTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('produtos').getDocuments(),
        builder: (context, snaphot) {
          if (!snaphot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snaphot.data.documents.map(
                (docs) {
                  return CategoriesTile(docs);
                },
              ).toList(),
            );
          }
        });
  }
}
