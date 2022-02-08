import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:music_store_flutter/widgets/login/action_button.dart';
import 'package:music_store_flutter/widgets/login/form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = "";
  String pass = "";

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void loginAction() {
    var bytes = utf8.encode(userController.text);
    var passCrypted = sha256.convert(bytes);

    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/home');
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(18.0),
                height: 450,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Iniciar sesión",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Color(0xFF303030)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(
                        "Entra con tu usuario para continuar",
                        style: TextStyle(
                            color: Color(0xFF928E8E),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
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
                                  heightField: 76,
                                  texto: "USUARIO",
                                  icono: Icons.person_rounded,
                                  obscure: false,
                                  controlador: userController,
                                  textoError: 'Introduce tu usuario',
                                  teclado: TextInputType.name,
                                  accion: TextInputAction.next),
                              const SizedBox(
                                height: 30,
                              ),
                              FormFieldLogin(
                                  heightField: 76,
                                  texto: "CONTRASEÑA",
                                  icono: Icons.lock,
                                  obscure: true,
                                  controlador: passController,
                                  textoError: 'Introduce tu contraseña',
                                  teclado: TextInputType.visiblePassword,
                                  accion: TextInputAction.done)
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () => {loginAction()},
                          child: const ActionButton(
                            text: "ENTRAR",
                            widthBtn: 135,
                          )),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 22.0),
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿No tienes una cuenta? ",
                      style: TextStyle(
                          color: Color(0xFF736F6F),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.5),
                    ),
                    GestureDetector(
                        onTap: () =>
                            {Navigator.pushNamed(context, '/register')},
                        child: const Text(
                          "Registrate ahora",
                          style: TextStyle(
                              color: Color(0xFF9C76EE),
                              fontWeight: FontWeight.w900,
                              fontSize: 15.5),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
