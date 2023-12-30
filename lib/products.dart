import 'package:ecommerce/components/ProductCard.dart';
import 'package:ecommerce/classes/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'ali-mobile.000webhostapp.com';



List<Product> _products = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
            int.parse(row['pid']),
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['category'],
            [],
            [],
            []);
        _products.add(p);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}


class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  var searchValue='';
  var filter='all';


  @override
  Widget build(BuildContext context) {


    return  Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey[100]),
          child:  TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'search',

            ),
            onChanged:(e)=>setState(() {
              searchValue=e;
            }),


          )
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 25),
          child: Text('Explore our great collection',style: TextStyle(color: Colors.grey),),

        ),
         Center(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,

            children: [
              GestureDetector(
                onTap: ()=>setState(() {
                  filter='all';
                }),
                child:  Container(

                  decoration: BoxDecoration(color: filter=='all'? Colors.purple:Colors.grey[200],borderRadius: BorderRadius.circular(30),),
                  padding: EdgeInsets.all(6),
                  child: Text('all',style: TextStyle(color: filter=='all'? Colors.white:Colors.black),),
                ),
              ),

              const SizedBox(width: 10,),
              GestureDetector(
                onTap: ()=>setState(() {
                  filter='hoodies';

                }),
                child: Container(

                  decoration: BoxDecoration(color:filter=='hoodies'? Colors.purple:Colors.grey[200],borderRadius: BorderRadius.circular(30),),
                  padding: EdgeInsets.all(6),
                  child: Text('hoodies',style: TextStyle(color: filter=='hoodies'? Colors.white:Colors.black)),
                ),
              ),

              const SizedBox(width: 10,),
              GestureDetector(
                onTap: ()=>setState(() {
                  filter='sweaters';
                }),
                child: Container(

                  decoration: BoxDecoration(color:filter=='sweaters'? Colors.purple:Colors.grey[200],borderRadius: BorderRadius.circular(30),),
                  padding: EdgeInsets.all(6),
                  child: Text('sweaters',style: TextStyle(color: filter=='sweaters'? Colors.white:Colors.black)),
                ),
              )

            ],
                   ),
         ),
        const SizedBox(height: 20,),
        
        Expanded(child: ListView.builder(itemCount: _products.length,scrollDirection: Axis.horizontal,itemBuilder:(context,index)=>

        filter=='all'?
        searchValue==''?ProductCard(p: _products[index]) : _products[index].name.contains(searchValue) ? ProductCard(p: _products[index]):Text(''):
        filter==_products[index].category?
        searchValue==''?ProductCard(p: _products[index]) : _products[index].name.contains(searchValue) ? ProductCard(p: _products[index]):Text(''):
        Text('')
        )),
        const Padding(padding:  EdgeInsets.symmetric(vertical:5,horizontal: 25))

      ],
    );
  }
}
