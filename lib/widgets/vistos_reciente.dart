import 'package:flutter/material.dart';

class VistosRecientemente extends StatefulWidget {
  const VistosRecientemente({Key? key}) : super(key: key);

  @override
  _VistosRecientementeState createState() => _VistosRecientementeState();
}

class _VistosRecientementeState extends State<VistosRecientemente> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Row(
            children: const [
              Text("Vistos recientmente"),
            ],
          ),
        ),
        SizedBox(
          height: 530,
          width: 328,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.8 / 2.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return productoVisto(
                  "https://storage.googleapis.com/music-store-flutter/Contrabass/contrabass3.png");
            },
          ),
        ),
        const Text(
          "Más artículos",
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF736F6F),
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget productoVisto(String img) => Card(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
        child: Container(
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
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(height: 185, child: Image.network(img)),
              ),
            ],
          ),
        ),
      );
}
