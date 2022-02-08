import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldLogin extends StatefulWidget {
  final double heightField;
  final String texto;
  final IconData icono;
  final bool obscure;
  final TextEditingController controlador;
  final String textoError;
  final TextInputType teclado;
  final TextInputAction accion;

  const FormFieldLogin(
      {Key? key,
      required this.heightField,
      required this.texto,
      required this.icono,
      required this.obscure,
      required this.controlador,
      required this.textoError,
      required this.teclado,
      required this.accion})
      : super(key: key);

  @override
  _FormFieldLoginState createState() => _FormFieldLoginState();
}

class _FormFieldLoginState extends State<FormFieldLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: widget.heightField,
      width: 345,
      decoration: const BoxDecoration(color: Color(0xFFFBFBFB), boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(3, 3),
            blurRadius: 15.0)
      ]),
      child: Row(
        children: [
          Icon(
            widget.icono,
            color: const Color(0xFF969494),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
              child: TextFormField(
            keyboardType: widget.teclado,
            validator: (value) {
              if (widget.texto == "USUARIO") {
                if (value == null || value.isEmpty) {
                  return widget.textoError;
                }
              }
              if (widget.texto == "CORREO ELECTRÓNICO") {
                if (value == null || value.isEmpty || !value.contains("@")) {
                  return widget.textoError;
                }
              }

              if (widget.texto == "CONTRASEÑA") {
                if (value == null || value.isEmpty) {
                  return widget.textoError;
                }
              }
            },
            controller: widget.controlador,
            autofocus: false,
            obscureText: widget.obscure,
            maxLength: 25,
            textInputAction: widget.accion,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            cursorColor: const Color(0xFF9E7EE2),
            decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: const TextStyle(
                    color: Color(0xFF969494),
                    fontSize: 12,
                    letterSpacing: 0.35),
                hintText: widget.texto),
          ))
        ],
      ),
    );
  }
}
