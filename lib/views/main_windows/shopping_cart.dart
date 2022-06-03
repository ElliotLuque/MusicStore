import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/widgets/dialog_message.dart';

UserData data = UserData();
double finalPrice = 0;

Future<List<List<dynamic>>> carroUsuario() async {
  return await Conexion.connection.query('''
                  SELECT id_carro
                  FROM carro
                  WHERE id_usuario = @user''',
      substitutionValues: {"user": await data.getData("id")});
}

Future<List<List<dynamic>>> productosCarroUsuario() async {
  return await Conexion.connection.query('''
                  SELECT id_producto, nombre, fabricante, descripcion, nombre_categoria, valoracion_media, imagen, producto_full, cantidad, precio_actual, id_carro
                  FROM producto_extendido
                  JOIN producto_carro_compra USING (id_producto)
                  WHERE id_carro IN (SELECT id_carro
                            FROM carro
                            WHERE id_usuario = @user)''',
      substitutionValues: {"user": await data.getData("id")});
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  Future<void> refrescar() async {
    finalPrice = 0;
    productosCarroUsuario();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: productosCarroUsuario(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            if (finalPrice == 0) {
              for (int i = 0; i < snapshot.data.length; i++) {
                finalPrice += snapshot.data[i][9] * snapshot.data[i][8];
              }
            }
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
                    child: RefreshIndicator(
                      onRefresh: () => refrescar(),
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: Container(
                                  height: 1.5,
                                  width: 340,
                                  color: const Color(0XFFEEE7E7),
                                ),
                              ),
                              const SizedBox(height: 10.0)
                            ],
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 150,
                            child: CartProduct(
                                idProd: snapshot.data[index][0],
                                prodName: snapshot.data[index][1],
                                brandName: snapshot.data[index][2],
                                cantidad: snapshot.data[index][8],
                                image: snapshot.data[index][6],
                                price: snapshot.data[index][9],
                                idCarro: snapshot.data[index][10],
                                callback: () {
                                  setState(() {});
                                }),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((finalPrice.toString()) + "€",
                            style: const TextStyle(
                                color: Color(0xFF3E3C3C),
                                fontSize: 33.5,
                                fontWeight: FontWeight.w900)),
                        GestureDetector(
                          onTap: () {
                            deleteCartProducts(snapshot.data[0][10]);
                            showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                animationType: DialogTransitionType.scale,
                                builder: (context) => const DialogMensajeIcon(
                                    text: "Pedido realizado correctamente!",
                                    image: "assets/check.png",
                                    navOption: 1));
                            setState(() {});
                          },
                          child: Container(
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
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
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          refrescar();
                        },
                        child: const Text("No tienes productos en el carrito",
                            style: TextStyle(
                              fontSize: 22,
                            )),
                      ))),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("0€",
                            style: TextStyle(
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
          }
        });
  }
}

//
// PRODUCT CARD
//

var formatNum = NumberFormat('##,###', "es_ES");
var formatNumDecimal = NumberFormat('##,###.0#', "es_ES");

Future<void> removeProduct(int idProd, int idCarro) async {
  await Conexion.connection.query('''DELETE FROM producto_carro_compra
      WHERE id_carro = @carro AND id_producto = @prod''',
      substitutionValues: {"prod": idProd, "carro": idCarro});
}

Future<void> deleteCartProducts(int idCarro) async {
  await Conexion.connection.query(
      '''DELETE FROM producto_carro_compra WHERE id_carro =@carro''',
      substitutionValues: {"carro": idCarro});
}

Future<void> changeCantidad(int idProd, int idCarro, int cantidad) async {
  await Conexion.connection.query(
      '''UPDATE producto_carro_compra SET cantidad = @cant
      WHERE id_carro = @carro AND id_producto = @prod''',
      substitutionValues: {"prod": idProd, "carro": idCarro, "cant": cantidad});
}

// ignore: must_be_immutable
class CartProduct extends ShoppingCartPage {
  final int idProd;
  final String prodName;
  final String brandName;
  final String image;
  final double price;
  final int cantidad;
  final int idCarro;
  final Function callback;
  const CartProduct(
      {Key? key,
      required this.idProd,
      required this.prodName,
      required this.brandName,
      required this.image,
      required this.price,
      required this.cantidad,
      required this.idCarro,
      required this.callback})
      : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  int cant = 0;
  @override
  Widget build(BuildContext context) {
    cant == 0 ? cant = widget.cantidad : cant;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const SizedBox(
            width: 2.0,
          ),
          SizedBox(
            height: 150,
            width: 100,
            child: CachedNetworkImage(
              imageUrl: widget.image,
            ),
          ),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.brandName,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.prodName,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF807D7D)),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                widget.price * cant % 1 == 0
                    ? formatNum.format(widget.price.round() * cant).toString() +
                        ' €'
                    : formatNumDecimal.format(widget.price * cant).toString() +
                        '€',
                style: const TextStyle(
                    color: Color(0xFF3E3C3C),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    cant++;
                    changeCantidad(widget.idProd, widget.idCarro, cant);
                    setState(() {
                      finalPrice += widget.price;
                    });
                    widget.callback();
                  },
                  icon: const Icon(Icons.add),
                  color: const Color(0xFFCBCBCB),
                  iconSize: 25,
                ),
                Text(
                  cant.toString(),
                  style: TextStyle(
                      fontSize: cant > 9 ? 22.5 : 28,
                      color: const Color(0xFF303030),
                      fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    if (cant == 1) {
                      removeProduct(widget.idProd, widget.idCarro);
                      productosCarroUsuario();
                      setState(() {
                        finalPrice = widget.price;
                      });
                    } else {
                      cant--;
                      changeCantidad(widget.idProd, widget.idCarro, cant);
                    }

                    setState(() {
                      finalPrice -= widget.price;
                    });
                    widget.callback();
                  },
                  icon: const Icon(Icons.remove),
                  color: const Color(0xFFCBCBCB),
                  iconSize: 23,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
