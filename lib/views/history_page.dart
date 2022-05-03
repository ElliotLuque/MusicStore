import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/views/product_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

UserData data = UserData();

Future<List<List<dynamic>>> selectDatos() async {
  return await Conexion.connection.query(
      '''SELECT id_producto, nombre, fabricante, imagen, valoracion_media, precio_actual, descripcion, id_usuario
         FROM producto_extendido 
	            JOIN historial_producto USING (id_producto)
         WHERE id_usuario = @user
         ORDER BY fecha_vista DESC''',
      substitutionValues: {"user": await data.getData("id")});
}

void navToProduct(
    BuildContext context,
    int idProd,
    String prodName,
    String brandName,
    String img,
    int rating,
    double price,
    String description) {
  Navigator.pushNamed(context, ProductPage.route,
      arguments: ProductArguments(
          idProd, prodName, brandName, img, rating, price, description));
}

var formatNum = NumberFormat('##,###', "es_ES");
var formatNumDecimal = NumberFormat('##,###.0#', "es_ES");

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 805,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data[index][4] == null) {
                          return productCardHistory(
                              snapshot.data[index][0],
                              snapshot.data[index][1],
                              snapshot.data[index][2],
                              snapshot.data[index][3],
                              0,
                              snapshot.data[index][5],
                              snapshot.data[index][6]);
                        } else {
                          return productCardHistory(
                              snapshot.data[index][0],
                              snapshot.data[index][1],
                              snapshot.data[index][2],
                              snapshot.data[index][3],
                              snapshot.data[index][4],
                              snapshot.data[index][5],
                              snapshot.data[index][6]);
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: const Color(0XFFEEE7E7),
                          height: 1,
                          width: 10,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text("No tienes productos guardados");
          }
        });
  }

  Widget productCardHistory(int id, String name, String brand, String image,
          int rating, double price, description) =>
      GestureDetector(
        onTap: () => {
          navToProduct(
              context, id, name, brand, image, rating, price, description)
        },
        child: Container(
          color: Colors.white,
          height: 110,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CachedNetworkImage(
                    imageUrl: image,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(3.3),
                child: SizedBox(
                  width: 230,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(
                          text: brand + " ",
                          style: const TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626)),
                          children: [
                            TextSpan(
                                text: name,
                                style: const TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF616060)))
                          ],
                        )),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: (rating >= 1
                                  ? const Color(0xFFFFD363)
                                  : const Color(0xFFACA9A9)),
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: (rating >= 2
                                  ? const Color(0xFFFFD363)
                                  : const Color(0xFFACA9A9)),
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: (rating >= 3
                                  ? const Color(0xFFFFD363)
                                  : const Color(0xFFACA9A9)),
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: (rating >= 4
                                  ? const Color(0xFFFFD363)
                                  : const Color(0xFFACA9A9)),
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: (rating == 5
                                  ? const Color(0xFFFFD363)
                                  : const Color(0xFFACA9A9)),
                              size: 20,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: Text(
                              price % 1 == 0
                                  ? formatNum.format(price.round()).toString() +
                                      ' €'
                                  : formatNumDecimal.format(price) + ' €',
                              style: const TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF262626))),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      );
}
