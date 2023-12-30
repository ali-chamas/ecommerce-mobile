import 'package:ecommerce/Cart.dart';
import 'package:ecommerce/components/ProductCard.dart';
import 'package:ecommerce/products.dart';
import 'package:ecommerce/components/BottomNav.dart';
import 'package:flutter/material.dart';

class ShoppinPage extends StatefulWidget {
  const ShoppinPage({super.key});

  @override
  State<ShoppinPage> createState() => _ShoppinPageState();
}

class _ShoppinPageState extends State<ShoppinPage> {
  bool _load = false;

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

  int _selectedIndex = 0;

  void navigateBottom(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [const Shop(), const Cart()];

  @override
  void initState() {
    updateProducts(update);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        onTabChange: (index) => navigateBottom(index),
      ),
      body: !_load ? const Center(
          child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
      )
     : _pages[_selectedIndex],
    );
  }
}
