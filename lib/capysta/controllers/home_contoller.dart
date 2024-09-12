import 'package:asdasdqweqweanimatin/capysta/models/Product.dart';
import 'package:asdasdqweqweanimatin/capysta/models/ProductItem.dart';
import 'package:flutter/material.dart';

enum HomeState { home, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.home;

  List<ProductItem> listProduct = [];

  void changeState(HomeState newState) {
    homeState = newState;
    notifyListeners();
  }

  void addToCart(Product product) {
    print(listProduct);
    print(product.title);
    for (ProductItem item in listProduct) {
      print(item);
      if (item.product!.title == product.title) {
        print(item.product!.title);
        item.increment();
        notifyListeners();
        return;
      }
    }
    listProduct.add(ProductItem(product: product));
    notifyListeners();
  }

  int getCurrentLength() {
    int _a = 0;
    for (ProductItem item in listProduct) {
      _a += item.quantity;
    }
    return _a;
  }
}
