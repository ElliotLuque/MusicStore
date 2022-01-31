import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_store_flutter/database/conexion.dart';

class OfertasProductoLista extends StatefulWidget {
  const OfertasProductoLista({
    Key? key,
  }) : super(key: key);

  @override
  State<OfertasProductoLista> createState() => _OfertasProductoLista();
}

class _OfertasProductoLista extends State<OfertasProductoLista> {
  Future<List<List<dynamic>>> selectDatos() async {
    return await Conexion.connection.query("SELECT * FROM ofertas");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (context, AsyncSnapshot resultados) {
          if (resultados.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text("Productos en oferta"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 295,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: resultados.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (resultados.data[index][6] == null) {
                          return productoCard(
                            resultados.data[index][7],
                            resultados.data[index][1],
                            resultados.data[index][2],
                            resultados.data[index][4],
                            0,
                          );
                        } else {
                          return productoCard(
                            resultados.data[index][7],
                            resultados.data[index][1],
                            resultados.data[index][2],
                            resultados.data[index][4],
                            resultados.data[index][6],
                          );
                        }
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
            return Container();
          }
        });
  }

  Widget productoCard(String img, String prodName, String brandName,
          double price, double rating) =>
      Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
            width: 172,
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
                      height: 175,
                      width: 135,
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
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brandName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF262626),
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            prodName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF736F6F)),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 11),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 1
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 2
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 3
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() >= 4
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating.round() == 5
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: 60,
                        padding: const EdgeInsets.all(4.5),
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
                              fontSize: 12),
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
