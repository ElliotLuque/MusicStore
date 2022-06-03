import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/views/login_page.dart';
import 'package:music_store_flutter/widgets/dialog_message.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

UserData data = UserData();

void logout(BuildContext context) {
  data.deleteData("id");
  data.deleteData("username");
  data.deleteData("password");
  data.deleteData("email");
  data.deleteData("profile_photo");

  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

void navToHistoryPage(BuildContext context) {
  Navigator.pushNamed(context, '/history');
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: FutureBuilder<String?>(
                  future: data.getData("profile_photo"),
                  builder: (context, AsyncSnapshot snapshot) {
                    return CircleAvatar(
                      backgroundColor: const Color(0XFFF6F6F6),
                      radius: 120,
                      backgroundImage: NetworkImage(snapshot.data.toString()),
                    );
                  }),
            ),
            const SizedBox(height: 20),
            FutureBuilder<String?>(
                future: data.getData("username"),
                builder: (context, AsyncSnapshot snapshot) {
                  return Text(snapshot.data.toString(),
                      style: const TextStyle(
                          color: Color(0xFF3E3C3C),
                          fontSize: 33.5,
                          fontWeight: FontWeight.w900));
                }),
            const SizedBox(height: 10),
            FutureBuilder<String?>(
                future: data.getData("email"),
                builder: (context, AsyncSnapshot snapshot) {
                  return Text(snapshot.data.toString(),
                      style: const TextStyle(
                          color: Color(0xFF96959C),
                          fontSize: 20.5,
                          fontWeight: FontWeight.w500));
                })
          ],
        ),
        const SizedBox(height: 40),
        Column(
          children: [
            Container(
              color: const Color(0XFFF6F6F6),
              width: double.infinity,
              height: 40,
              child: const Padding(
                padding: EdgeInsets.only(left: 5.0, top: 9.0),
                child: Text("OPCIONES",
                    style: TextStyle(
                        color: Color(0xFF96959C),
                        fontSize: 20.5,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            GestureDetector(
              onTap: () => {navToHistoryPage(context)},
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.history,
                      color: Color(0xFF474554),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Historial",
                        style: TextStyle(
                            color: Color(0xFF474554),
                            fontSize: 22.5,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 1,
                width: 300,
                color: const Color(0XFFEEE7E7),
              ),
            ),
            GestureDetector(
              onTap: () => showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  animationType: DialogTransitionType.scale,
                  builder: (context) => const DialogMensajeIcon(
                      text:
                          "Aplicación realizada como TFG Elliot Luque - 2º DAM",
                      image: 'assets/info.png',
                      navOption: 1)),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.help_outline,
                      color: Color(0xFF474554),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Acerca de",
                        style: TextStyle(
                            color: Color(0xFF474554),
                            fontSize: 22.5,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 1,
                width: 300,
                color: const Color(0XFFEEE7E7),
              ),
            ),
            GestureDetector(
              onTap: () => {logout(context)},
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Color(0XFFDD6666),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Salir",
                        style: TextStyle(
                            color: Color(0xFFDD6666),
                            fontSize: 22.5,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 1,
                width: 300,
                color: const Color(0XFFEEE7E7),
              ),
            ),
          ],
        )
      ],
    );
  }
}
