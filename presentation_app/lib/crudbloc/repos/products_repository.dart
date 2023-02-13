import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presentation_app/crudbloc/models/products.dart';

class ApiService{
  static const String baseUrl = "https://fakestoreapi.com";

  static const headers = {'Content-type':'application/json'};

  Future<List<Products>> getAllProducts() async {
    return http.get(Uri.parse('$baseUrl/products'), headers: headers).then((data){

      final products = <Products>[];
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        for(var product in jsonData){
          products.add(Products.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => print(err));
  }

  Future<List<Products>> addProduct(Products product, List<Products> products) async {
    var response = await http.post(Uri.parse('$baseUrl/products'), headers: headers, body: jsonEncode(
        {
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'image': product.image,
          'category': product.category
        }));

    if(response.statusCode == 200 ){
      products.add(product);
    }
    return products;

  }

  Future<List<Products>> updateProduct(Products product, List<Products> products) async {
    final tempProducts = <Products>[];
    for(var tempProduct in products)
      {
        if(tempProduct.id == product.id)
          {
            tempProduct = product;
          }
        tempProducts.add(tempProduct);
      }
      return tempProducts;
  }

  Future<List<Products>> deleteProduct(List<Products> products, int index) async {
    await products.removeAt(index);
    return products;

  }

}
