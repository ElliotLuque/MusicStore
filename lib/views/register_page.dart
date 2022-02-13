import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/widgets/dialog_message.dart';
import 'package:music_store_flutter/widgets/login/action_button.dart';
import 'package:music_store_flutter/widgets/login/form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController newUserController = TextEditingController();
  TextEditingController newMailController = TextEditingController();
  TextEditingController newTlfController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  String encryptPass(String pass) {
    var bytes = utf8.encode(pass);
    var passCrypted = sha256.convert(bytes).toString();
    return passCrypted;
  }

  Future<void> insertUser() async {
    await Conexion.connection
        .query('''INSERT INTO usuario (id_usuario, nombre, email, telefono, pass)
    VALUES (DEFAULT, @nombre, @email, @telefono, @pass)''',
            substitutionValues: {
          "nombre": newUserController.text,
          "email": newMailController.text,
          "telefono":
              newTlfController.text.isEmpty ? null : newTlfController.text,
          "pass": encryptPass(newPassController.text)
        });
  }

  void registerAction() {
    if (formKey.currentState!.validate()) {
      insertUser();
      showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          animationType: DialogTransitionType.scale,
          builder: (BuildContext context) {
            return const DialogMensajeIcon(
              text: "Usuario registrado correctamente!",
              image: 'assets/check.png',
              navOption: 2,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: Image.asset(
                      'assets/arrow-small-left_gray.png',
                      scale: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(18.0),
                height: 680,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Crear cuenta",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF303030)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              FormFieldLogin(
                                heightField: 62,
                                texto: "USUARIO",
                                icono: Icons.person_rounded,
                                obscure: false,
                                controlador: newUserController,
                                textoError: 'Introduce un nombre válido',
                                teclado: TextInputType.name,
                                accion: TextInputAction.next,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              FormFieldLogin(
                                heightField: 62,
                                texto: "CORREO ELECTRÓNICO",
                                icono: Icons.mail_outline,
                                obscure: false,
                                controlador: newMailController,
                                textoError: 'Introduce un correo válido',
                                teclado: TextInputType.emailAddress,
                                accion: TextInputAction.next,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              FormFieldLogin(
                                heightField: 62,
                                texto: "TELÉFONO (OPCIONAL)",
                                icono: Icons.phone,
                                obscure: false,
                                controlador: newTlfController,
                                textoError: 'Introduce un teléfono válido',
                                teclado: TextInputType.phone,
                                accion: TextInputAction.next,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              FormFieldLogin(
                                heightField: 62,
                                texto: "CONTRASEÑA",
                                icono: Icons.lock,
                                obscure: true,
                                controlador: newPassController,
                                textoError: 'Introduce una contraseña válida',
                                teclado: TextInputType.visiblePassword,
                                accion: TextInputAction.done,
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => {registerAction()},
                          child: const ActionButton(
                            text: "REGISTRARSE",
                            widthBtn: 180.0,
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
