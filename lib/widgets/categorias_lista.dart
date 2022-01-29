import 'package:flutter/material.dart';

class CategoriasLista extends StatefulWidget {
  const CategoriasLista({Key? key}) : super(key: key);

  @override
  _CategoriasListaState createState() => _CategoriasListaState();
}

class _CategoriasListaState extends State<CategoriasLista> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text("Categorías"),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 25.0),
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
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 128,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return categoriaCard(
                  "https://storage.googleapis.com/music-store-flutter/TenorSax/tenor%20sax2.png",
                  "Viento Metal",
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 7,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriaCard(String img, String categoriaName) => Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
          width: 115,
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
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(height: 79, child: Image.network(img)),
              ),
              Text(categoriaName,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      );
}
