import 'package:flutter/material.dart';
import 'package:lojavirtual/Tabs/HomeTab.dart';
import 'package:lojavirtual/Tabs/OrdersTab.dart';
import 'package:lojavirtual/Tabs/PlacesTab.dart';
import 'package:lojavirtual/Tabs/ProdutosTab.dart';
import 'package:lojavirtual/widgets/CartButton.dart';
import 'package:lojavirtual/widgets/CustomDrawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
          body: ProdutosTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
