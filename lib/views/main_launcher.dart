import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_store_flutter/views/main_windows/home.dart';
import 'package:music_store_flutter/views/main_windows/liked_products.dart';
import 'package:music_store_flutter/views/main_windows/search.dart';
import 'package:music_store_flutter/views/main_windows/shopping_cart.dart';
import 'package:music_store_flutter/views/main_windows/user_profile.dart';

class AppLauncher extends StatefulWidget {
  const AppLauncher({Key? key}) : super(key: key);

  @override
  State<AppLauncher> createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  int currentSelectedIndexNavBar = 0;
  final screens = [
    const HomePage(),
    const SearchPage(),
    const ShoppingCartPage(),
    const LikedProductsPage(),
    const UserProfilePage(),
  ];

  void onNavBarItemTapped(int index) {
    currentSelectedIndexNavBar = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFBF8F8),
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 23,
          currentIndex: currentSelectedIndexNavBar,
          onTap: onNavBarItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Buscar"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: "Carrito"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: "Guardados"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Perfil"),
          ],
        ),
        body: IndexedStack(
          index: currentSelectedIndexNavBar,
          children: screens,
        ));
  }
}
