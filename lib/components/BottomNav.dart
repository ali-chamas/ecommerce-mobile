import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class BottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
   BottomNav({super.key,required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return   Container(
      child:  GNav(
        color: Colors.grey[500],
        activeColor: Colors.purple,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: (value)=>onTabChange!(value),
        tabs: const [
          GButton(icon: Icons.home,text: 'Shop',),
           GButton(icon: Icons.shopping_bag_rounded,text: 'cart',)
        ],
      ),
    );
  }
}
