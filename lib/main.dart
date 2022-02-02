import 'package:flutter/material.dart';
import 'package:music_store_flutter/views/main_page.dart';
import 'package:flutter/services.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/views/product_page.dart';

void main() async {
  await Conexion().conectar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFBF8F8),
        systemNavigationBarIconBrightness: Brightness.dark));

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        ProductPage.route: (context) => ProductPage(),
      },
    );
  }
}
