import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NovedadesCarousel extends StatefulWidget {
  const NovedadesCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<NovedadesCarousel> createState() => _NovedadesCarousel();
}

class _NovedadesCarousel extends State<NovedadesCarousel> {
  Future<List<List<dynamic>>> selectDatos() async {
    return await Conexion.connection.query("SELECT * FROM novedades");
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: selectDatos(),
        builder: (context, AsyncSnapshot resultados) {
          if (resultados.hasData) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Novedades")),
                ),
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 260,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                    itemCount: resultados.data.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return mostrarContenedor(
                          resultados.data[index][1],
                          resultados.data[index][2],
                          resultados.data[index][5],
                          resultados.data[index][4],
                          resultados.data[index][3],
                          resultados.data[index][7]);
                    }),
                const SizedBox(
                  height: 9,
                ),
                Center(
                  child: mostrarIndicador(),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget mostrarContenedor(String prodName, String brandName,
          String categoryName, double price, String description, String img) =>
      Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
          width: 365,
          decoration: BoxDecoration(
              color: const Color(0xFFFEFCFE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(3, 3),
                    blurRadius: 4.0)
              ]),
          child: Row(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: SizedBox(
                        width: 145,
                        height: 200,
                        child: CachedNetworkImage(
                          imageUrl: img,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        categoryName,
                        style: const TextStyle(
                            color: Color(0xFF736F6F),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandName.toUpperCase(),
                      style: const TextStyle(
                          color: Color(0XFF3E3C3C),
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        prodName,
                        style: const TextStyle(
                            color: Color(0xFF736F6F),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 190,
                      height: 80,
                      child: Text(
                        description,
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF736F6F),
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      price % 1 == 0
                          ? price.round().toString() + ' €'
                          : '$price €',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Color(0XFF3E3C3C)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget mostrarIndicador() => FutureBuilder<List<List<dynamic>>>(
      future: selectDatos(),
      builder: (context, AsyncSnapshot resultados) {
        if (resultados.hasData) {
          return AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: resultados.data.length,
            effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 4,
                activeDotColor: Color(0xFF303030),
                dotColor: Color(0xFFC4C4C4)),
          );
        } else {
          return Container();
        }
      });
}
