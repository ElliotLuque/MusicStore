import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_store_flutter/database/conexion.dart';

class ProductosRandomLista extends StatefulWidget {
  const ProductosRandomLista({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductosRandomLista> createState() => _ProductosRandomListaState();
}

class _ProductosRandomListaState extends State<ProductosRandomLista> {
  Future<List<List<dynamic>>> categoriaRand() async {
    return await Conexion.connection.query(
        "SELECT id_categoria, nombre FROM subcategorias ORDER BY RANDOM() LIMIT 1");
  }

  Future<List<List<dynamic>>> selectDatos() async {
    List<List<dynamic>> idCatRandom = await categoriaRand();
    return await Conexion.connection.query(
        "SELECT * FROM producto_extendido WHERE categoria = @cat",
        substitutionValues: {"cat": idCatRandom[0][0]});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (context, AsyncSnapshot resultados) {
          if (resultados.hasData && resultados.data.length > 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(resultados.data[0][6]),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                          "MÁS",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF736F6F),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 248,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: resultados.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return productoCard(
                            resultados.data[index][8],
                            resultados.data[index][1],
                            resultados.data[index][2],
                            resultados.data[index][4],
                            resultados.data[index][7]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 12,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.only(top: 13.0),
              child: Center(
                child: Text(
                  "Aún no tenemos productos de esta categoría :(",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF736F6F)),
                ),
              ),
            );
          }
        });
  }

  Widget productoCard(String img, String prodName, String brandName,
          double price, double rating) =>
      Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
            width: 143,
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                      height: 145,
                      width: 125,
                      child: CachedNetworkImage(
                        imageUrl: img,
                      )),
                ),
                const SizedBox(
                  height: 17,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brandName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF262626),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            prodName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xFF736F6F)),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 1
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 2
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 3
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 4
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() == 5
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: 50,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2C44D),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          price % 1 == 0
                              ? price.round().toString() + ' €'
                              : '$price €',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF363636),
                              fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
}
