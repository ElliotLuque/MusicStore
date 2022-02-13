import 'package:flutter/material.dart';
import 'package:music_store_flutter/controller/secure_storage.dart';
import 'package:music_store_flutter/views/login_page.dart';
import 'package:music_store_flutter/views/main_page.dart';
import 'package:flutter/services.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/views/product_page.dart';
import 'package:music_store_flutter/views/register_page.dart';
import 'package:music_store_flutter/views/splash_screen.dart';

void main() async {
  await Conexion().conectar();
  runApp(const MyApp());
}

UserData data = UserData();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));

    return FutureBuilder<bool>(
        future: data.hasData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == true) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Music Store',
              theme: ThemeData(
                  primaryColor: const Color(0xFF9272D6),
                  primaryColorLight: const Color(0xFFAE90EE),
                  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: Color(0xFFFBF8F8),
                      selectedItemColor: Color(0xFF9272D6),
                      unselectedItemColor: Color(0xFFC4C4C4))),
              initialRoute: '/home',
              routes: {
                '/splash': (context) => const SplashScreen(),
                '/home': (context) => const HomePage(),
                '/login': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
                ProductPage.route: (context) => const ProductPage(),
              },
            );
          } else if (snapshot.data == false) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Music Store',
              theme: ThemeData(
                  primaryColor: const Color(0xFF9272D6),
                  primaryColorLight: const Color(0xFFAE90EE),
                  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: Color(0xFFFBF8F8),
                      selectedItemColor: Color(0xFF9272D6),
                      unselectedItemColor: Color(0xFFC4C4C4))),
              initialRoute: '/login',
              routes: {
                '/splash': (context) => const SplashScreen(),
                '/login': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
                '/home': (context) => const HomePage(),
                ProductPage.route: (context) => const ProductPage(),
              },
            );
          } else {
            return Container();
          }
        });
  }
}
