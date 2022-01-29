import 'package:flutter/material.dart';

class ProductosRandomLista extends StatefulWidget {
  final String categoria;

  const ProductosRandomLista({Key? key, required this.categoria})
      : super(key: key);

  @override
  State<ProductosRandomLista> createState() => _ProductosRandomListaState();
}

class _ProductosRandomListaState extends State<ProductosRandomLista> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.categoria),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text(
                  "MÁS",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF736F6F),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 248,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return productoCard(
                    "https://storage.googleapis.com/music-store-flutter/Contrabass/contrabass3.png",
                    "Bussetto IB",
                    "Scala Vilagio",
                    4969,
                    4);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 12,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget productoCard(String img, String prodName, String brandName, int price,
          int rating) =>
      Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
            width: 143,
            decoration: BoxDecoration(
                color: const Color(0xFFFEFCFE),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(2, 2),
                      blurRadius: 4.0)
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 145,
                    width: 125,
                    child: Image.network(
                      img,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brandName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF262626),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            prodName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xFF736F6F)),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: (rating >= 1
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 2
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 3
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating >= 4
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                          Icon(
                            Icons.star,
                            color: (rating == 5
                                ? const Color(0xFFFFD363)
                                : const Color(0xFFACA9A9)),
                            size: 12,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: 50,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2C44D),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          '$price €',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF363636),
                              fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
}
