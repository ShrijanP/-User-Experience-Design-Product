import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/cart_view.dart';
import 'package:food_assignment/features/profile_page/presentation/screen/profile_page_view.dart';
// import 'package:food_assignment/features/favorite_page/favorite_page_view.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import 'package:food_assignment/features/home_page/home_page_view.dart';
// import 'package:food_assignment/features/profile_page/profile_page_view.dart';
import 'package:food_assignment/features/search_page/search_page_view.dart';
import 'package:food_assignment/features/shared/constants/size_config.dart';

import 'favorite_page/presentation/screen/favorite_page_view.dart';
import 'home_page/presentation/screen/components/colors.dart';
import 'home_page/presentation/screen/home_page_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screen = [
    const HomePageView(),
    const SearchPageView(),
    const CartView(),
    const FavoritePageView(),
    const ProfilePageView(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(Icons.home, size: SizeConfig.screenHeight! / 30.77),
      Icon(Icons.search, size: SizeConfig.screenHeight! / 30.77),
      Icon(Icons.shopping_cart, size: SizeConfig.screenHeight! / 30.77),
      Icon(Icons.favorite, size: SizeConfig.screenHeight! / 30.77),
      Icon(Icons.person, size: SizeConfig.screenHeight! / 30.77),
    ];
    Size size = MediaQuery.of(context).size;
    return Container(
      color: buttonColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: screen[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: Colors.black45,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: buttonColor,
              height: 60.0,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 400),
              index: index,
              items: items,
              onTap: (index) => setState(() => this.index = index),
            ),
          ),
        ),
      ),
    );
  }
}
