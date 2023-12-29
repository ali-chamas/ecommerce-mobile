import 'package:ecommerce/shop.dart';
import 'package:flutter/material.dart';




class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body:
     Center(
       child:Column(
         mainAxisAlignment: MainAxisAlignment.center,
       
       children: [
         Padding(padding: const EdgeInsets.all(25.0),
         child:Image.network("https://media.istockphoto.com/id/872222650/photo/mini-store-on-a-white-background-3d-rendering.webp?b=1&s=170667a&w=0&k=20&c=lRRLyv5lehaZqnlMtlsYqzdu087e3K2Vu_JV9NuZY-A=",height: 300,),
         ),
         const SizedBox(height: 40,),

         const Text("Welcome to My Shop",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),),

         const SizedBox(height: 24,),

         const Text('Brand new hoodies and sweaters to elevate your style',style: TextStyle(fontSize: 16,color: Colors.grey),textAlign: TextAlign.center,),
         const SizedBox(height: 40,),
         GestureDetector(
           onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppinPage())),

          child:Container(
           padding: const EdgeInsets.all(15),
           
           decoration:  BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(12),),child: const Text('Shop Now!',style: TextStyle(color: Colors.white),),
         ))
       ],
     ),)
    );
  }
}
