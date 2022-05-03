import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/database/conexion.dart';

class LikedProductsPage extends StatefulWidget {
  const LikedProductsPage({Key? key}) : super(key: key);

  @override
  State<LikedProductsPage> createState() => _LikedProductsPageState();
}

UserData data = UserData();

var formatNum = NumberFormat('##,###', "es_ES");
var formatNumDecimal = NumberFormat('##,###.0#', "es_ES");

Future<List<List<dynamic>>> selectDatos() async {
  return await Conexion.connection.query(
      '''SELECT id_producto, nombre, fabricante, imagen, valoracion_media, precio_actual, descripcion, id_usuario
         FROM producto_extendido 
	          JOIN favoritos_producto USING (id_producto)
         WHERE id_usuario = @user''',
      substitutionValues: {"user": await data.getData("id")});
}

Future<void> removeFavorite(int idProd) async {
  await Conexion.connection.query('''DELETE FROM favoritos_producto
                                         WHERE id_producto = @prod
                                         AND id_usuario = @user''',
      substitutionValues: {"user": await data.getData("id"), "prod": idProd});
}

class _LikedProductsPageState extends State<LikedProductsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return SizedBox(
              height: 800,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 37, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: const [
                          Text("Productos guardados",
                              style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 25.4,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(height: 2),
                          Text("Guarda tus productos favoritos",
                              style: TextStyle(
                                  color: Color(0xFF736F6F),
                                  fontSize: 16.4,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.5,
                  ),
                  SizedBox(
                    height: 665,
                    width: 360,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: snapshot.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        if (snapshot.data[index][4] == null) {
                          return productCardFav(
                            snapshot.data[index][0],
                            snapshot.data[index][1],
                            snapshot.data[index][2],
                            snapshot.data[index][3],
                            0,
                            snapshot.data[index][5],
                            snapshot.data[index][6],
                          );
                        } else {
                          return productCardFav(
                            snapshot.data[index][0],
                            snapshot.data[index][1],
                            snapshot.data[index][2],
                            snapshot.data[index][3],
                            snapshot.data[index][4],
                            snapshot.data[index][5],
                            snapshot.data[index][6],
                          );
                        }
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 0);
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 37, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: const [
                          Text("Productos guardados",
                              style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 25.4,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(height: 2),
                          Text("Guarda tus productos favoritos",
                              style: TextStyle(
                                  color: Color(0xFF736F6F),
                                  fontSize: 16.4,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget productCardFav(int idProd, String prodName, String brandName,
          String image, int rating, double price, String description) =>
      Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xFFFEFCFE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(2, 2),
                    blurRadius: 4.0)
              ]),
          child: Row(
            children: [
              SizedBox(
                width: 85,
                height: 85,
                child: CachedNetworkImage(
                  imageUrl: image,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text.rich(TextSpan(
                          text: brandName + " ",
                          style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626)),
                          children: [
                            TextSpan(
                                text: prodName,
                                style: const TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF616060)))
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: (rating >= 1
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 21,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 2
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 21,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 3
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 21,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 4
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 21,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating == 5
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          price % 1 == 0
                              ? formatNum.format(price.round()).toString() +
                                  ' €'
                              : formatNumDecimal.format(price) + ' €',
                          style: const TextStyle(
                              fontSize: 19.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626))),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  removeFavorite(idProd);
                  setState(() {});
                },
                child: const Icon(
                  Icons.favorite,
                  size: 32,
                  color: Color(0xFFE7300C),
                ),
              ),
            ],
          ),
        ),
      );
}
