import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/Model/CartModel.dart';
import 'package:lojavirtual/Model/UserModel.dart';
import 'package:lojavirtual/Screens/LoginScreen.dart';
import 'package:lojavirtual/Screens/OrderScreen.dart';
import 'package:lojavirtual/Tiles/CartTile.dart';
import 'package:lojavirtual/widgets/CardPrice.dart';
import 'package:lojavirtual/widgets/DiscountCart.dart';
import 'package:lojavirtual/widgets/ShipCard.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(
                    fontSize: 17.0
                  ),
                );
              }
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                  size: 80.0, color: Theme.of(context).primaryColor,),
                  SizedBox(height: 16.0,),
                  Text(
                    "Faça login para adicionar produtos no carrinho!",
                    style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                    child: Text(
                      "Entrar", style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    },
                  )
                ],
              ),
            );
          }
          else if(model.products == null || model.products.length == 0){
            return Center(
              child: Text(
                "Nenhum produto no carrinho",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          else
            {
              return ListView(
                children: <Widget>[
                  Column(
                    children: model.products.map((products){
                      return CartTile(products);
                    }).toList(),
                  ),
                  DiscountCard(),
                  ShipCard(),
                  CardPrice(() async {
                    String orderId = await model.finishOrder();
                    if (orderId != null){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                      );
                    }
                  })
                ],
              );
            }
        },
      ),
    );
  }
}
