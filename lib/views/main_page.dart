import 'package:flutter/material.dart';
import 'package:music_store_flutter/widgets/categorias_lista.dart';
import 'package:music_store_flutter/widgets/novedades_carousel.dart';
import 'package:music_store_flutter/widgets/oferta_producto_lista.dart';
import 'package:music_store_flutter/widgets/productos_random_lista.dart';
import 'package:music_store_flutter/widgets/vistos_reciente.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndexNavBar = 0;

  void onNavBarItemTapped(int index) {
    setState(() {
      selectedIndexNavBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 23,
          items: const <BottomNavigationBarItem>[
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
          currentIndex: selectedIndexNavBar,
          onTap: onNavBarItemTapped,
        ),
        body: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xFF303030),
              fontSize: 24.5,
              fontWeight: FontWeight.w700,
            ),
            child: Column(
              children: const [
                OfertasProductoLista(),
                SizedBox(
                  height: 37,
                ),
                CategoriasLista(),
                SizedBox(
                  height: 37,
                ),
                NovedadesCarousel(),
                SizedBox(
                  height: 37,
                ),
                ProductosRandomLista(),
                SizedBox(
                  height: 37,
                ),
                ProductosRandomLista(),
                SizedBox(
                  height: 37,
                ),
                VistosRecientemente(),
                SizedBox(
                  height: 37,
                )
              ],
            ),
          ),
        ));
  }
}
