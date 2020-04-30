import 'package:flutter/material.dart';
import 'package:lojavirtual/data/produtos_data.dart';

class ProductTile extends StatelessWidget {
  final String tipo;
  final ProdutosData data;

  ProductTile(this.tipo, this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: tipo == 'Grid'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      data.image[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            data.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                          Text(
                            'R\$ ${data.preco}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(),
      ),
    );
  }
}
