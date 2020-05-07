import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/carrinho_data.dart';
import 'package:lojavirtual/data/produtos_data.dart';
import 'package:lojavirtual/models/carrinho_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/carrinho_screen.dart';
import 'package:lojavirtual/screens/login_screen.dart';

class ItenScreen extends StatefulWidget {
  final ProdutosData produto;

  ItenScreen(this.produto);

  @override
  _ItenScreenState createState() => _ItenScreenState(produto);
}

class _ItenScreenState extends State<ItenScreen> {
  final ProdutosData produto;
  String tamanho;
  _ItenScreenState(this.produto);
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.1,
            child: Carousel(
              images: produto.image.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 5,
              dotSpacing: 15,
              dotColor: primaryColor,
              autoplay: true,
              autoplayDuration: const Duration(seconds: 10),
              dotBgColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  produto.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(100, 100, 255, 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.5,
                    ),
                    children: produto.size.map(
                      (size) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              tamanho = size;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                  width: 2,
                                  color: size == tamanho
                                      ? Colors.indigoAccent
                                      : primaryColor),
                            ),
                            width: 20,
                            alignment: Alignment.center,
                            child: Text(size),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: OutlineButton(
                    onPressed: tamanho != null
                        ? () {
                            if (UserModel.of(context).logado()) {
                              Produtoscarrinho item = Produtoscarrinho();
                              item.tamanho = tamanho;
                              item.quantidade = 1;
                              item.produtoid = produto.id;
                              item.categorie = produto.categorie;
                              CarrinhoModel.of(context)
                                  .addProdutoCarrinho(item);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => CarrinhoScreen(),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text(UserModel.of(context).logado()
                        ? 'Adicionar ao carrinho'
                        : 'Entre para comprar'),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                    splashColor: Colors.indigoAccent,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Descrição',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  produto.descricao,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
