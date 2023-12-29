import 'package:ecommerce/components/ProductCard.dart';
import 'package:flutter/material.dart';
class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'search',

            ),
          )
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 25),
          child: Text('Explore our great collection'),

        ),
        const Row(
          children: [
            Text('filtering')
          ],
        ),
        const SizedBox(height: 20,),
        
        Expanded(child: ProductCard())

      ],
    );
  }
}
