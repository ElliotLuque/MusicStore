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
  List<List<dynamic>> resultados = [];

  Future<void> selectDatos() async {
    resultados = await Conexion.connection.query("SELECT * FROM producto");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
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
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return productoCard(
                  "https://storage.googleapis.com/music-store-flutter/Instrument_images/TenorSax/tenor_sax_01.png",
                  "YTS-480",
                  "Yamaha",
                  559,
                  4,
                );
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
  }

  Widget productoCard(String img, String prodName, String brandName, int price,
          int rating) =>
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
                      height: 175, width: 135, child: Image.network(img)),
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
                            color: (rating >= 1
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 2
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 3
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 4
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating == 5
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
                          '$price €',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF363636),
                              fontSize: 14),
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
