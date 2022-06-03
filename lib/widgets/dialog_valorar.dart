import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/widgets/dialog_message.dart';
import 'package:postgres/postgres.dart';

class ValorarDialog extends StatefulWidget {
  final int idUser;
  final int idProduct;
  const ValorarDialog({Key? key, required this.idUser, required this.idProduct})
      : super(key: key);

  @override
  State<ValorarDialog> createState() => _ValorarDialogState();
}

Future<void> addValoracion(
    int idProd, int idUser, int valor, BuildContext context) async {
  try {
    await Conexion.connection.query(
        '''INSERT INTO valoracion_producto (id_producto, id_usuario, valoracion)
                  VALUES (@prod, @user, @valor)''',
        substitutionValues: {"prod": idProd, "user": idUser, "valor": valor});
  } on PostgreSQLException catch (_) {
    showAnimatedDialog(
        context: context,
        builder: (context) => const DialogMensajeIcon(
            text: "Ya has valorado este producto",
            image: "assets/info.png",
            navOption: 1));
  }
}

Future<void> valoracionProd(int idProd, int idUser) async {
  await Conexion.connection.query(
      '''SELECT * FROM valoracion_producto WHERE id_producto = @prod AND id_usuario = @user''',
      substitutionValues: {"prod": idProd, "user": idUser});
}

class _ValorarDialogState extends State<ValorarDialog> {
  int valoracionFinal = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
            height: 130,
            width: 60,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: const Color(0xFFFEFCFE),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(3, 3),
                      blurRadius: 4.0)
                ]),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        valoracionFinal = 1;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.star,
                        color: (valoracionFinal >= 1
                            ? const Color(0xFFFFD363)
                            : const Color(0xFFACA9A9)),
                        size: 37,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        valoracionFinal = 2;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.star,
                        color: (valoracionFinal >= 2
                            ? const Color(0xFFFFD363)
                            : const Color(0xFFACA9A9)),
                        size: 37,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        valoracionFinal = 3;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.star,
                        color: (valoracionFinal >= 3
                            ? const Color(0xFFFFD363)
                            : const Color(0xFFACA9A9)),
                        size: 37,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        valoracionFinal = 4;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.star,
                        color: (valoracionFinal >= 4
                            ? const Color(0xFFFFD363)
                            : const Color(0xFFACA9A9)),
                        size: 37,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        valoracionFinal = 5;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.star,
                        color: (valoracionFinal == 5
                            ? const Color(0xFFFFD363)
                            : const Color(0xFFACA9A9)),
                        size: 37,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.5),
                GestureDetector(
                  onTap: () {
                    addValoracion(widget.idProduct, widget.idUser,
                        valoracionFinal, context);

                    Navigator.pop(context);
                  },
                  child: const Text("Valorar",
                      style: TextStyle(
                          color: Color(0xFF9E7EE2),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                )
              ],
            )));
  }
}
