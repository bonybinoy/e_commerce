import 'package:e_commerce/screens/home_page.dart';
import 'package:e_commerce/widget/icon_widget.dart';
import 'package:e_commerce/screens/wishlist_page.dart';
import 'package:flutter/material.dart';

import '../screens/cart_page.dart';

int pageIndex = 0;
final pages = [HomePage(), WishlistPage(), CartPage()];

class BottomnavWidget extends StatefulWidget {
  final int index;

  const BottomnavWidget({super.key, required this.index});

  @override
  State<BottomnavWidget> createState() => _BottomnavWidgetState();
}

class _BottomnavWidgetState extends State<BottomnavWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            backgroundColor: Colors.white,
            icon: pageIndex == 0
                ? const IconWidget(
                    icon: Icons.home,
                    color: Colors.blue,
                  )
                : const IconWidget(
                    icon: Icons.home_outlined,
                  ),
          ),
          BottomNavigationBarItem(
            label: "Wishlist",
            icon: pageIndex == 1
                ? const IconWidget(
                    icon: Icons.favorite,
                    color: Colors.blue,
                  )
                : const IconWidget(
                    icon: Icons.favorite_outline,
                  ),
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: pageIndex == 2
                ? const IconWidget(
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  )
                : const IconWidget(
                    icon: Icons.shopping_cart_outlined,
                  ),
          ),
        ],
      ),
    );
  }
}
