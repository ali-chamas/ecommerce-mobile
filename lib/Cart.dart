import 'package:ecommerce/classes/Cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'ali-mobile.000webhostapp.com';



List<CartClass> cartItems = [];
double totalPrice=0;
void updatePrice(){
  totalPrice=0;
  for(int i =0;i<cartItems.length;i++){

      totalPrice=totalPrice+cartItems[i].price;


  }

}
void updateCart(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getFromCart.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    cartItems.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        CartClass c = CartClass(
          int.parse(row['itemID']),
          row['name'],
          double.parse(row['price']),
          row['image'],
          int.parse(row['quantity'])
        );
        cartItems.add(c);
        updatePrice();

      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}


class _CartState extends State<Cart> {

  bool _load=false;
  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) {
        // API request failed
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }




  @override
  void initState() {
    updateCart(update);


    super.initState();
  }
  void deleteDromCart(int id) async {
    try {

      final response = await http.get(
        Uri.parse('https://ali-mobile.000webhostapp.com/deleteFromCart.php?id=$id'),
      );

      if (response.statusCode == 200) {
        updateCart(update);
        updatePrice();
        // if successful, call the update function
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('deleted!')));
      }

    }
    catch(e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('failed to delete')));
    }
  }
  void clearCart() async {
    if(cartItems.length>0){
    try {

      final response = await http.get(
        Uri.parse('https://ali-mobile.000webhostapp.com/clearCart.php'),
      );

      if (response.statusCode == 200) {
        updateCart(update);
        updatePrice();
        // if successful, call the update function
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('checkout succesful!')));
      }

    }
    catch(e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('failed to delete')));
    }
  }

  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Expanded(child: ListView.builder(itemCount: cartItems.length,shrinkWrap: true,itemBuilder: (context,index)=>
              Container(
                
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(10)),
                child:
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(cartItems[index].image,height: 80,width: 80,fit: BoxFit.cover,),
                      Column(
                        children: [
                          Text(cartItems[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('\$ ${cartItems[index].price}',style: TextStyle(fontSize: 18,color: Colors.grey),),
                        ],
                      ),
                      IconButton(onPressed: ()=>deleteDromCart(cartItems[index].id), icon: Icon(Icons.delete))
                    ],
                  ),
                )


              )
          )),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(20))
            ,
            padding: EdgeInsets.all(10),
            width: 200,

            
            
            child: Center(
              child:
                   cartItems.length<=0? Text('Go Shopping first'):
                   Column(
                     children: [
                  Text("Total : \$ ${totalPrice}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ElevatedButton(onPressed: clearCart, child: Text('Checkout'))
                ],
              ),
            )
          )
        ],

      ),
    );
  }
}
