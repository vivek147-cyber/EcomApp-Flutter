import 'dart:convert';
import 'dart:developer';

import 'package:ecom_app/api/api_constants.dart';
import 'package:ecom_app/models/products_models.dart';
import 'package:http/http.dart' as http;

class ProductController {


  Future<List<Products>?> fetchProductsData() async {
    try {
        final url = Uri.parse(ApiConstants.baseURL+ApiConstants.productsURL);
        final response = await http.get(url);

        if(response.statusCode == 200)
        {
          List<dynamic> data = json.decode(response.body);

          List<Products> productList = data.map((product) => Products.fromJson(product)).toList();
        
          return productList; 
        }
        else
        {
             throw Exception('Failed to Load Data');

        }

    } catch (e) {
         log(e.toString());
         return [];
         
    }
  }

   

  Future<List<Products>?> fetchProductsByCategory({String? category}) async {
    try {
         final url = Uri.parse('${ApiConstants.baseURL}${ApiConstants.productsURL}${ApiConstants.categoryURL}/electronics');
        
        final response = await http.get(url);
        
        if(response.statusCode == 200)
        {
          List<dynamic> data = json.decode(response.body);
 
          List<Products> productByCategoryList = data.map((product) => Products.fromJson(product)).toSet().toList();
        
          return productByCategoryList; 
        }
        else
        {
             throw Exception('Failed to Load Data');

        }
    } catch (e) {
      log(e.toString());
         return [];
    }
  }
}
