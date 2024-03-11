import 'dart:convert';
import 'package:ecom_app/models/products_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends ChangeNotifier {
  Map<int, bool?> cart = {};

  List<Products?> cartList = [];

  Map<int, bool?> get getCart => cart;

  List<Products?> get getCartList => cartList;

  bool isCart(int? id) {
    return cart[id] ?? false;
  }

  void addToCart(Products? product) {
    bool isInCart = cartList.any((element) => element?.id == product?.id);

    if (isInCart) {
      Products? existingProduct =
          cartList.firstWhere((element) => element?.id == product?.id);
      if (existingProduct != null) {
        existingProduct.quantity++;
      }
    } else {
      product!.quantity = 1;
      cartList.add(product);
    }
    saveCartToPreferences();
    notifyListeners();
  }

  void removeFromCart(Products? product) {
    cartList.removeWhere((element) => element?.id == product?.id);
    saveCartToPreferences();
    notifyListeners();
  }

  void incrementQuantity(Products? product) {
    product?.quantity++;
    saveCartToPreferences();
    notifyListeners();
  }

  void decrementQuantity(Products? product) {
    if (product!.quantity > 1) {
      product.quantity--;
      saveCartToPreferences();
      notifyListeners();
    }
  }

  void toggle(int? id) {
    cart[id ?? -1] = !(cart[id ?? -1] ?? false);
    saveCartToPreferences();
    notifyListeners();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;

    for (Products? product in cartList) {
      totalPrice += (product!.price * product.quantity);
    }
    saveCartToPreferences();
    return totalPrice;
  }

  Future<void> saveCartToPreferences() async {
    SharedPreferences cartPrefers = await SharedPreferences.getInstance();

    List<String> cartItems = cartList
        .map((product) {
          Map<String, dynamic>? productJson = product?.toJson();
          productJson?['isCart'] = cart[product?.id] ?? false;
          return jsonEncode(productJson);
        })
        .toList(); //saving json data of products in local storage
    
    cartPrefers.setInt('cartList Length', cartItems.length);
    cartPrefers.setStringList('cart', cartItems);
  }

  Future<void> getCartToPreferences() async {
    SharedPreferences getCartPrefers = await SharedPreferences.getInstance();

    List<String> cartItems = getCartPrefers.getStringList('cart') ?? [];

    cartList = cartItems.map((item) {
      Products product = Products.fromJson(jsonDecode(item));
      cart[product.id] = jsonDecode(item)['isCart'];
      return product;
    }).toList();

    getCartPrefers.getInt('cartList Length');

    notifyListeners();
  }
}
