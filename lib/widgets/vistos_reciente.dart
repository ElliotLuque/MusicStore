import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_store_flutter/database/conexion.dart';

class VistosRecientemente extends StatefulWidget {
  const VistosRecientemente({Key? key}) : super(key: key);

  @override
  _VistosRecientementeState createState() => _VistosRecientementeState();
}

class _VistosRecientementeState extends State<VistosRecientemente> {
  Future<List<List<dynamic>>> selectDatos() async {
    return await Conexion.connection.query(
        ''' SELECT DISTINCT ON (imagenes_producto.id_producto) producto.id_producto, imagen
FROM historial_producto
INNER JOIN producto USING (id_producto)
INNER JOIN imagenes_producto USING (id_producto)
''');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (context, AsyncSnapshot resultados) {
          if (resultados.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: const [
                      Text("Vistos recientemente"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 530,
                  width: 328,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1.8 / 2.7,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: resultados.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return productoVisto(resultados.data[index][1]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget productoVisto(String img) => Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
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
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                    height: 185,
                    child: CachedNetworkImage(
                      imageUrl: img,
                    )),
              ),
            ],
          ),
        ),
      );
}
