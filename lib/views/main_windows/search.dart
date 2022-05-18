import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:music_store_flutter/database/conexion.dart';
import 'package:music_store_flutter/views/product_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

Future<List<List<dynamic>>> allProducts() async {
  return await Conexion.connection.query(
      '''SELECT id_producto, nombre, fabricante, imagen, valoracion_media, precio_actual, descripcion, producto_full, nombre_categoria
         FROM producto_extendido''');
}

Future<List<List<dynamic>>> subcategorias() async {
  return await Conexion.connection.query('''
         SELECT id_categoria, nombre
         FROM subcategorias''');
}

void navToProduct(
    BuildContext context,
    int idProd,
    String prodName,
    String brandName,
    String img,
    int rating,
    double price,
    String description) {
  Navigator.pushNamed(context, ProductPage.route,
      arguments: ProductArguments(
          idProd, prodName, brandName, img, rating, price, description));
}

var formatNum = NumberFormat('##,###', "es_ES");
var formatNumDecimal = NumberFormat('##,###.0#', "es_ES");

TextEditingController buscarController = TextEditingController();
final formKey = GlobalKey<FormState>();

class _SearchPageState extends State<SearchPage> {
  int selectedCatIndex = 0;
  bool selected = false;
  List<List<dynamic>> encontrados = [];

  Future<void> refrescar(List<List<dynamic>> list) async {
    filterName(buscarController.text, list);
    setState(() {});
  }

  void filterName(String query, List<List<dynamic>> todos) {
    encontrados = todos;
    List<List<dynamic>> resultados = [];
    if (query.isEmpty) {
      resultados = todos;
    } else {
      resultados = todos
          .where((product) => (product[8] + product[7])
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      encontrados = resultados;
    });
  }

  void filterCategory(String query, List<List<dynamic>> todos) {
    encontrados = todos;
    List<List<dynamic>> resultados = [];
    if (query.isEmpty) {
      resultados = todos;
    } else {
      resultados = todos
          .where((product) =>
              (product[8]).toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      encontrados = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: subcategorias(),
        builder: (context, AsyncSnapshot categoriasResult) {
          if (categoriasResult.hasData && categoriasResult.data.length > 0) {
            return FutureBuilder<List<List<dynamic>>>(
                future: allProducts(),
                builder: (context, AsyncSnapshot datosResult) {
                  if (datosResult.hasData && datosResult.data.length > 0) {
                    return SizedBox(
                      height: 800,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.5),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    height: 55,
                                    width: 345,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFFBFBFB),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: const [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.15),
                                              offset: Offset(3, 3),
                                              blurRadius: 15.0)
                                        ]),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Form(
                                          key: formKey,
                                          child: Flexible(
                                              child: TextFormField(
                                            onChanged: (text) => {
                                              filterName(buscarController.text,
                                                  datosResult.data)
                                            },
                                            controller: buscarController,
                                            autofocus: false,
                                            maxLength: 25,
                                            maxLengthEnforcement:
                                                MaxLengthEnforcement.enforced,
                                            cursorColor:
                                                const Color(0xFF9E7EE2),
                                            decoration: const InputDecoration(
                                                counterText: "",
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF969494),
                                                    fontSize: 16,
                                                    letterSpacing: 0.35),
                                                hintText: "Buscar..."),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      filterName(buscarController.text,
                                          datosResult.data);
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 5.0, left: 10.0),
                                      child: Icon(
                                        Icons.search,
                                        size: 30,
                                        color: Color(0xFF9E7EE2),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: SizedBox(
                                height: 43,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoriasResult.data.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(width: 15);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () => {
                                        if (selected)
                                          {
                                            selected = false,
                                            filterName(buscarController.text,
                                                datosResult.data)
                                          }
                                        else
                                          {
                                            filterCategory(
                                                categoriasResult.data[index][1],
                                                encontrados),
                                            selected = true,
                                          },
                                        selectedCatIndex = index,
                                      },
                                      child: categoryCard(
                                          categoriasResult.data[index][1],
                                          index),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                height: 578,
                                child: RefreshIndicator(
                                  color: const Color(0xFF9E7EE2),
                                  onRefresh: () => refrescar(datosResult.data),
                                  child: GridView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 300,
                                      childAspectRatio: 1.8 / 2.7,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                    ),
                                    itemCount: encontrados.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (encontrados[index][4] == null) {
                                        return productCard(
                                          encontrados[index][0],
                                          encontrados[index][1],
                                          encontrados[index][2],
                                          encontrados[index][3],
                                          0,
                                          encontrados[index][5],
                                          encontrados[index][6],
                                        );
                                      } else {
                                        return productCard(
                                          encontrados[index][0],
                                          encontrados[index][1],
                                          encontrados[index][2],
                                          encontrados[index][3],
                                          encontrados[index][4],
                                          encontrados[index][5],
                                          encontrados[index][6],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        });
  }

  Widget productCard(int idProd, String prodName, String brandName,
          String image, int rating, double price, String description) =>
      GestureDetector(
        onTap: () => {
          navToProduct(context, idProd, prodName, brandName, image, rating,
              price, description)
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(2, 2),
                    blurRadius: 4.0)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: SizedBox(
                    height: 155,
                    width: 130,
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(brandName,
                    style: const TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF262626))),
                Text(prodName,
                    style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF736F6F))),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: (rating >= 1
                              ? const Color(0xFFFFD363)
                              : const Color(0xFFACA9A9)),
                          size: 16.5,
                        ),
                        Icon(
                          Icons.star,
                          color: (rating >= 2
                              ? const Color(0xFFFFD363)
                              : const Color(0xFFACA9A9)),
                          size: 16.5,
                        ),
                        Icon(
                          Icons.star,
                          color: (rating >= 3
                              ? const Color(0xFFFFD363)
                              : const Color(0xFFACA9A9)),
                          size: 16.5,
                        ),
                        Icon(
                          Icons.star,
                          color: (rating >= 4
                              ? const Color(0xFFFFD363)
                              : const Color(0xFFACA9A9)),
                          size: 16.5,
                        ),
                        Icon(
                          Icons.star,
                          color: (rating == 5
                              ? const Color(0xFFFFD363)
                              : const Color(0xFFACA9A9)),
                          size: 16.5,
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 65,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF2C44D),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(2, 2),
                                blurRadius: 4.0)
                          ]),
                      child: Center(
                        child: Text(
                            price % 1 == 0
                                ? formatNum.format(price.round()).toString() +
                                    ' €'
                                : formatNumDecimal.format(price) + ' €',
                            style: const TextStyle(
                                fontSize: 14.7,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF262626))),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget categoryCard(String text, int index) => Container(
      padding: const EdgeInsets.only(left: 8.5, right: 8.5),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      decoration: BoxDecoration(
          color: index == selectedCatIndex && selected
              ? const Color(0XFF514174)
              : const Color(0xFF9E7EE2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(2, 2),
                blurRadius: 4.0)
          ]));
}
