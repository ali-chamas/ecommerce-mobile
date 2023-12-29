import 'package:ecommerce/Cart.dart';
import 'package:ecommerce/products.dart';
import 'package:ecommerce/components/BottomNav.dart';
import 'package:flutter/material.dart';

class ShoppinPage extends StatefulWidget {
  const ShoppinPage({super.key});

  @override
  State<ShoppinPage> createState() => _ShoppinPageState();
}

class _ShoppinPageState extends State<ShoppinPage> {
  int _selectedIndex=0;

  void navigateBottom(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  final List<Widget> _pages=[
    const Shop(),
    const Cart()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNav(
        onTabChange: (index)=>navigateBottom(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

