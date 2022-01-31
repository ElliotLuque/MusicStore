import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_store_flutter/database/conexion.dart';

class CategoriasLista extends StatefulWidget {
  const CategoriasLista({Key? key}) : super(key: key);

  @override
  _CategoriasListaState createState() => _CategoriasListaState();
}

class _CategoriasListaState extends State<CategoriasLista> {
  Future<List<List<dynamic>>> selectDatos() async {
    return await Conexion.connection.query("SELECT * FROM categorias");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (context, AsyncSnapshot resultados) {
          if (resultados.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text("Categorías"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 128,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: resultados.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return categoriaCard(
                          resultados.data[index][2],
                          resultados.data[index][1],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 7,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget categoriaCard(String img, String categoriaName) => Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
          width: 115,
          decoration: BoxDecoration(
              color: const Color(0xFFFEFCFE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(2, 2),
                    blurRadius: 4.0)
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    height: 79,
                    child: CachedNetworkImage(
                      imageUrl: img,
                    )),
              ),
              Text(categoriaName,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      );
}
