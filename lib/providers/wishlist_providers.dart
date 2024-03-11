
import 'dart:convert';
import 'package:ecom_app/models/products_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends ChangeNotifier {

     Map<int,bool> fav = {};

     List<Products> wishList = [];

     Map<int, bool> get getIsFav => fav;

     List<Products> get getWishList => wishList;

     bool isFav(int? id)
     {
      return fav[id] ?? false;
     }

     void addToWishList(Products? product)
     {
        wishList.add(product!);
        saveCartToPreferences();
        notifyListeners();
     }

      void removeFromWishList(Products? product)
     {
        wishList.remove(product);
        saveCartToPreferences();
        notifyListeners();
     }

     void toggle(int? id)
     {
         fav[id ?? -1] = !(fav[id ?? -1] ?? false);
         saveCartToPreferences();
         notifyListeners();
     }


      Future<void> saveCartToPreferences() async {
    SharedPreferences cartPrefers = await SharedPreferences.getInstance();

   List<String> wishlistItems = wishList.map((product) {
    Map<String, dynamic> productJson = product.toJson();
    productJson['isFav'] = fav[product.id] ?? false;
    return jsonEncode(productJson);
  }).toList();
 //saving json data of products in local storage

    cartPrefers.setStringList('wishlist', wishlistItems);
  }

  Future<void> getCartToPreferences() async {
    SharedPreferences getCartPrefers = await SharedPreferences.getInstance();

    List<String> wishlistItems = getCartPrefers.getStringList('wishlist') ?? [];

    wishList = wishlistItems.map((item) {
      Products product = Products.fromJson(jsonDecode(item));
      fav[product.id] = jsonDecode(item)['isFav'];
      return product;
    }).toList();

    notifyListeners();
  }

}