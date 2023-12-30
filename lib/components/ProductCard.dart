import 'package:ecommerce/classes/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/classes/Images.dart';
import 'package:ecommerce/classes/Sizes.dart';
import 'package:ecommerce/classes/Colors.dart' ;

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'ali-mobile.000webhostapp.com';



class ProductCard extends StatefulWidget {
  Product p;


  ProductCard({super.key,required this.p});


  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {



void addToCart( String name,double price,String image,int quantity) async{
  try {

    final response = await http.get(
        Uri.parse('https://ali-mobile.000webhostapp.com/addToCart.php?name=$name&price=$price&image=$image&quantity=$quantity'),
        );

    if (response.statusCode == 200) {
      // if successful, call the update function
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('added to cart!')));
    }
  }
  catch(e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('failed to add')));
  }
}


    void  fetchImages(Function(bool success) update) async{
     try {
       final response = await http.get(Uri.parse('https://ali-mobile.000webhostapp.com/getImage.php?id=${widget.p.pid}')).timeout(const Duration(seconds: 5));
       widget.p.images.clear();
       if (response.statusCode == 200) {
         final jsonResponse = convert.jsonDecode(response.body);
         for (var row in jsonResponse) {
           ImagesClass i =ImagesClass(
             row['imageString']

           );
           widget.p.images.add(i);
         }
         update(true);
       }
     } catch (e) {
       update(false);
     }
   }
    void  fetchSizes(Function(bool success) update) async{
      try {

        final response = await http.get(Uri.parse('https://ali-mobile.000webhostapp.com/getSizes.php?id=${widget.p.pid}')).timeout(const Duration(seconds: 5));
        widget.p.sizes.clear();

        if (response.statusCode == 200) {
          final jsonResponse = convert.jsonDecode(response.body);
          for (var row in jsonResponse) {
            SizesClass s =SizesClass(
                row['size']

            );
            widget.p.sizes.add(s);
          }
          update(true);
        }
      } catch (e) {
        update(false);
      }
    }

    void  fetchColors(Function(bool success) update) async{
      try {

        final response = await http.get(Uri.parse('https://ali-mobile.000webhostapp.com/getColors.php?id=${widget.p.pid}')).timeout(const Duration(seconds: 5));
        widget.p.colors.clear();

        if (response.statusCode == 200) {
          final jsonResponse = convert.jsonDecode(response.body);
          for (var row in jsonResponse) {
            ColorsClass c =ColorsClass(
                row['color']

            );
            widget.p.colors.add(c);
          }
          update(true);
        }
      } catch (e) {
        update(false);
      }
    }
    bool _load = false;

    void update(bool success) {
      setState(() {
        _load = true; // show product list
        if (!success) {
          // API request failed
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('failed to load images')));
        }
      });
    }
    @override
    void initState() {
      fetchSizes(update);
      fetchImages(update);
      fetchColors(update);

      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left:25),
      width: 280,
        decoration: BoxDecoration(
        color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12)
    ),

    child:
    widget.p.sizes.length>0 && widget.p.colors.length>0 && widget.p.images.length>0?
    Padding(
      padding: const EdgeInsets.only(left:8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child:  ClipRRect(
            borderRadius:BorderRadius.circular(12),
            child:Image.network(widget.p.images[0].imageString,fit: BoxFit.cover,height: 250,width: 273,),
          ),


        ),


        Expanded(child: ListView.builder(itemCount: widget.p.sizes.length,shrinkWrap: true,scrollDirection: Axis.horizontal,itemBuilder: ( context, index){
          return Container(
            height: 5,

            child:
              Text('${widget.p.sizes[index].size}  ',style: TextStyle(color: Colors.grey[700],fontSize: 11),)

          );
        }),),
        Expanded(child: ListView.builder(itemCount: widget.p.colors.length,shrinkWrap: true,scrollDirection: Axis.horizontal,itemBuilder: ( context, index){
          return Container(
              height: 5,

              child:
              Text('${widget.p.colors[index].color}  ',style: TextStyle(color: Colors.grey[700],fontSize: 11),)

          );
        }),),


        Padding(
          padding: const EdgeInsets.only(left:25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [

                Text(widget.p.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text('\$ ${widget.p.price}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
              ],),
              GestureDetector(
                onTap: ()=>addToCart(widget.p.name, widget.p.price, widget.p.images[0].imageString,widget.p.quantity),
                child: Container(padding: EdgeInsets.all(20),decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(14)),
                  child: Icon(Icons.add,color: Colors.white,),

                ),
              )



            ],
          ),
        )









      ],
      ),
    ): const Center(
        child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator())
    )
    );
  }
}
