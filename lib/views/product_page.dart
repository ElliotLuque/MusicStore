import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  static const String route = '/product_page';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int cantProducto = 1;
  int activeIndex = 0;

  bool liked = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFFFFFF)));

    final ProductArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ProductArguments;

    var formatNum = NumberFormat('##,###', "es_ES");
    var formatNumDecimal = NumberFormat('##,###.0#', "es_ES");

    Future<List<List<dynamic>>> imagenesProd() async {
      return await Conexion.connection.query(
          "SELECT id_producto, imagen FROM imagenes_producto WHERE id_producto = @prod",
          substitutionValues: {"prod": arguments.idProd});
    }

    return Scaffold(
      body: FutureBuilder<List<List<dynamic>>>(
          future: imagenesProd(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/product_bg.png'),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26.0, top: 13.5),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            SystemChrome.setSystemUIOverlayStyle(
                                const SystemUiOverlayStyle(
                                    systemNavigationBarColor: Color(0xFFFBF8F8),
                                    systemNavigationBarIconBrightness:
                                        Brightness.dark));
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/arrow-left.png',
                            scale: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        clipBehavior: Clip.none,
                        height: 370,
                        width: 500,
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            enableInfiniteScroll: false,
                            height: 260,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return CachedNetworkImage(
                              imageUrl: snapshot.data[index][1],
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 190.0),
                          child: AnimatedSmoothIndicator(
                            activeIndex: activeIndex,
                            count: snapshot.data.length,
                            effect: WormEffect(
                                dotHeight: 13,
                                dotWidth: 13,
                                spacing: 4,
                                activeDotColor: snapshot.data.length > 1
                                    ? const Color(0xFF303030)
                                    : const Color(0xFFEEEAF8),
                                dotColor: snapshot.data.length > 1
                                    ? const Color(0xFFC4C4C4)
                                    : const Color(0xFFEEEAF8)),
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 22.0, bottom: 5.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              child: GestureDetector(
                                child: Icon(
                                  liked == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: liked
                                      ? const Color(0xFFE7300C)
                                      : Colors.white,
                                ),
                                onTap: () {
                                  liked == false ? liked = true : liked = false;

                                  setState(() {
                                    liked;
                                  });
                                },
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFB293F4),
                                  borderRadius: BorderRadius.circular(17),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        offset: Offset(2, 2),
                                        blurRadius: 4.0)
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.5,
                    ),
                    Container(
                      height: 327,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(28.5),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  arguments.brandName,
                                  style: const TextStyle(
                                      color: Color(0xFF3E3C3C),
                                      fontSize: 26.5,
                                      fontWeight: FontWeight.w900),
                                ),
                                const Spacer(),
                                Text(
                                  arguments.price % 1 == 0
                                      ? formatNum
                                              .format(arguments.price.round())
                                              .toString() +
                                          ' €'
                                      : formatNumDecimal
                                              .format(arguments.price)
                                              .toString() +
                                          '€',
                                  style: const TextStyle(
                                      color: Color(0xFF8861DC),
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        arguments.prodName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF807D7D),
                                            fontSize: 24.5),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: (arguments.rating >= 1
                                                ? const Color(0xFFFFD363)
                                                : const Color(0xFFACA9A9)),
                                            size: 21,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (arguments.rating >= 2
                                                ? const Color(0xFFFFD363)
                                                : const Color(0xFFACA9A9)),
                                            size: 21,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (arguments.rating >= 3
                                                ? const Color(0xFFFFD363)
                                                : const Color(0xFFACA9A9)),
                                            size: 21,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (arguments.rating >= 4
                                                ? const Color(0xFFFFD363)
                                                : const Color(0xFFACA9A9)),
                                            size: 21,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: (arguments.rating == 5
                                                ? const Color(0xFFFFD363)
                                                : const Color(0xFFACA9A9)),
                                            size: 21,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 330,
                                        child: Text(
                                          arguments.description,
                                          maxLines: 4,
                                          style: const TextStyle(
                                              color: Color(0xFF8E8B8B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 23,
                                      ),
                                    ],
                                  ),
                                )),
                            Row(
                              children: [
                                SizedBox(
                                  width: 122,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cantProducto == 1
                                              ? cantProducto == 1
                                              : cantProducto--;
                                          setState(() {
                                            cantProducto;
                                          });
                                        },
                                        icon: const Icon(Icons.remove),
                                        color: const Color(0xFFCBCBCB),
                                        iconSize: 23,
                                      ),
                                      Text(
                                        cantProducto.toString(),
                                        style: TextStyle(
                                            fontSize:
                                                cantProducto > 9 ? 22.5 : 28,
                                            color: const Color(0xFF303030),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          cantProducto++;
                                          setState(() {
                                            cantProducto;
                                          });
                                        },
                                        icon: const Icon(Icons.add),
                                        color: const Color(0xFFCBCBCB),
                                        iconSize: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 22.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    width: 205,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF9272D6),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: const [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              offset: Offset(2, 2),
                                              blurRadius: 4.0)
                                        ]),
                                    child: const Text(
                                      "Añadir al carrito",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

class ProductArguments {
  final int idProd;
  final String prodName;
  final String brandName;
  final String img;
  final int rating;
  final double price;
  final String description;

  ProductArguments(this.idProd, this.prodName, this.brandName, this.img,
      this.rating, this.price, this.description);
}
