import 'package:flutter/material.dart';

class DialogMensajeIcon extends StatefulWidget {
  final String text;
  final String image;
  final int navOption;
  const DialogMensajeIcon(
      {Key? key,
      required this.text,
      required this.image,
      required this.navOption})
      : super(key: key);

  @override
  _DialogMensajeIconState createState() => _DialogMensajeIconState();
}

class _DialogMensajeIconState extends State<DialogMensajeIcon> {
  void onTapDialog(int op) {
    if (op == 1) {
      Navigator.pop(context);
    }
    if (op == 2) {
      Navigator.popUntil(context, ModalRoute.withName('/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 165,
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
        child: Column(children: [
          ClipRRect(
            child: Image.asset(
              widget.image,
              scale: 14,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () => {onTapDialog(widget.navOption)},
            child: const Text(
              "Aceptar",
              style: TextStyle(
                  color: Color(0xFF9E7EE2),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
        ]),
      ),
    );
  }
}
