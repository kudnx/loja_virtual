import 'package:flutter/material.dart';
import 'package:lojavirtual/Model/CartModel.dart';
import 'package:lojavirtual/Model/UserModel.dart';
import 'package:lojavirtual/Screens/LoginScreen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/SingupScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
                title: 'Loja Virtual Flutter',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Color.fromARGB(255, 4, 125, 141)
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen()
            ),
          );
        }
      ),
    );
  }
}