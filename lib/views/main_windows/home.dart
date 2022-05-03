import 'package:flutter/material.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/widgets/categorias_lista.dart';
import 'package:music_store_flutter/widgets/novedades_carousel.dart';
import 'package:music_store_flutter/widgets/oferta_producto_lista.dart';
import 'package:music_store_flutter/widgets/productos_random_lista.dart';
import 'package:music_store_flutter/widgets/vistos_reciente.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

UserData data = UserData();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              height: 23,
            )
          ],
        ),
      ),
    );
  }
}
