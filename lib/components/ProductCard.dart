
import 'package:ecommerce/classes/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'ali-mobile.000webhostapp.com';

List<Product> _products =[];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
          row['pid'],
          row['name'],
          row['quantity'],
          row['price'],
          row['category'],
          row['description'],
          ['sm ','md'],
          ['red','blue'],
          ['image']



            );
        _products.add(p);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}




class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return 
      Column(
        children: [
          
          ElevatedButton(onPressed: ()=>updateProducts((success) => null), child: Text('show')),
          Text('$_products.length')
        ],
      );
  
  }

}
