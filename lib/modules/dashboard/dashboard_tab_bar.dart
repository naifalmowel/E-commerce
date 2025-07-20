import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/cart/view/cart_page.dart';
import 'package:sumer/modules/dashboard/dashboard_page.dart';
import 'package:sumer/modules/user/view/user_details.dart';
import 'package:sumer/util/colors.dart';
import 'package:badges/badges.dart' as badges;

class DashboardTabBar extends StatefulWidget {
  const DashboardTabBar({super.key});

  @override
  State<DashboardTabBar> createState() => _DashboardTabBarState();
}

class _DashboardTabBarState extends State<DashboardTabBar> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    CartPage(showBack: false,),
    DashBoard(),
    UserDetails(showBack: false,),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:width>800 ? DashBoard(): IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar:width>800 ?null : ConvexAppBar(

        shadowColor: Colors.black,
        elevation: 2,
        backgroundColor: Colors.white,
        color:secondaryColor.withAlpha(204) ,
        activeColor: secondaryColor.withAlpha(204),
        items: [
          TabItem( icon:_selectedIndex == 0 ? Icons.shopping_cart: Obx(()=>badges.Badge(
            showBadge: Get.find<CartController>().cartItemsQTY.value != 0,
            badgeContent: Text(
              '${Get.find<CartController>().cartItemsQTY.value}',
              style: const TextStyle(color: Colors.white),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              elevation: 2,
            ),
            child: Icon(Icons.shopping_cart , color: secondaryColor.withAlpha(204),),
          )), title: "Cart"),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}
