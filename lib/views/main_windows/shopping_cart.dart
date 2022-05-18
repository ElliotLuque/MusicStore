import 'package:flutter/material.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/database/conexion.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

UserData data = UserData();

Future<List<List<dynamic>>> carroUsuario() async {
  return await Conexion.connection.query('''
                  SELECT id_carro
                  FROM carro
                  WHERE id_usuario = @user''',
      substitutionValues: {"user": await data.getData("id")});
}

Future<List<List<dynamic>>> productosCarroUsuariso(int carro) async {
  return await Conexion.connection.query('''
                  SELECT *
                  FROM producto_carro_compra
                  WHERE id_carro = @carro''',
      substitutionValues: {"carro": carro});
}

Future<List<List<dynamic>>> productosCarroUsuario() async {
  return await Conexion.connection.query('''
                  SELECT id_producto, nombre, fabricante, descripcion, nombre_categoria, valoracion_media, imagen, producto_full, cantidad, precio_actual
                  FROM producto_extendido
                  JOIN producto_carro_compra USING (id_producto)
                  WHERE id_carro IN (SELECT id_carro
                            FROM carro
                            WHERE id_usuario = @user)''',
      substitutionValues: {"user": await data.getData("id")});
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: productosCarroUsuario(),
        builder: (context, AsyncSnapshot snapshot) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Carro de compra",
                              style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 25.4,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 570,
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 40,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 40,
                          child: Text(snapshot.data[index][1]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            (snapshot.data[0][8] * snapshot.data[0][9])
                                    .toString() +
                                "€",
                            style: const TextStyle(
                                color: Color(0xFF3E3C3C),
                                fontSize: 33.5,
                                fontWeight: FontWeight.w900)),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: 180,
                          decoration: BoxDecoration(
                              color: const Color(0xFF9272D6),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(2, 2),
                                    blurRadius: 4.0)
                              ]),
                          child: const Text(
                            "COMPRAR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
