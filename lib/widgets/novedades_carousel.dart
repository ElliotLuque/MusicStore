import 'package:flutter/material.dart';
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
  int activeIndex = 0;

  final prodNames = ["JCL-750SQ", "360 C", "A40", "JPO42"];
  final brandNames = ["JUPITER", "HOHNER", "CORE", "JOHN PACKER"];
  final categories = [
    "Clarinetes",
    "Armónicas",
    "Contrabajos",
    "Saxofones tenor"
  ];
  final prices = [999, 20, 1999, 599];
  final descriptions = [
    "Clave Sib, cuerpo y campana en madera de granadillo, llaves plateadas ergonómicas...",
    "Harmonica con cositas street afinada en C do",
    "Contrabaix double bass lorem ipsum jejaj jejej lbla",
    "Saxofonaco con cosas de plata y cositas blablabla"
  ];
  final images = [
    "https://storage.googleapis.com/music-store-flutter/Clarinet/clarinet.png",
    "https://storage.googleapis.com/music-store-flutter/Harmonica/harmonica.png",
    "https://storage.googleapis.com/music-store-flutter/Contrabass/contrabass3.png",
    "https://storage.googleapis.com/music-store-flutter/TenorSax/tenor%20sax2.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child:
              Align(alignment: Alignment.centerLeft, child: Text("Novedades")),
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
          itemCount: 4,
          itemBuilder: (context, index, realIndex) {
            final String prod = prodNames[index];
            final String brand = brandNames[index];
            final String categor = categories[index];
            final int price = prices[index];
            final String descrip = descriptions[index];
            final String img = images[index];

            return mostrarContenedor(prod, brand, categor, price, descrip, img);
          },
        ),
        const SizedBox(
          height: 9,
        ),
        Center(
          child: mostrarIndicador(),
        )
      ],
    );
  }

  Widget mostrarContenedor(String prods, String brandNames, String categor,
          int price, String descrip, String img) =>
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
                        child: Image.network(img),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        categor,
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
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandNames,
                      style: const TextStyle(
                          color: Color(0XFF3E3C3C),
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        prods,
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
                      child: Text(
                        descrip,
                        textAlign: TextAlign.start,
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
                      price.toString() + "€",
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

  Widget mostrarIndicador() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 4,
        effect: const WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            spacing: 4,
            activeDotColor: Color(0xFF303030),
            dotColor: Color(0xFFC4C4C4)),
      );
}
