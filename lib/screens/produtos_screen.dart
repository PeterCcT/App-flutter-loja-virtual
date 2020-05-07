import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/produtos_data.dart';
import 'package:lojavirtual/tiles/produtos_tile.dart';

class CategoriesScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoriesScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('produtos')
              .document(snapshot.documentID)
              .collection('itens')
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.65),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ProdutosData data = ProdutosData.fromDocument(
                        snapshot.data.documents[index],
                      );
                      data.categorie = this.snapshot.documentID;
                      return ProductTile('Grid', data);
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ProdutosData data = ProdutosData.fromDocument(
                        snapshot.data.documents[index],
                      );
                      data.categorie = this.snapshot.documentID;
                      return ProductTile('list', data);
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
