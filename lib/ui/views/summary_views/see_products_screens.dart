import 'package:acfashion_store/domain/controller/controllerConectivity.dart';
import 'package:acfashion_store/ui/models/assets_model.dart';
import 'package:acfashion_store/ui/models/product_model.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/styles/my_colors.dart';
import 'package:acfashion_store/ui/views/add_product_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeProductsScreen extends StatefulWidget {
  final productos;
  final productoAgestionar;
  SeeProductsScreen({super.key, this.productos, this.productoAgestionar});

  @override
  State<SeeProductsScreen> createState() => _SeeProductsScreenState();
}

class _SeeProductsScreenState extends State<SeeProductsScreen> {
  ControlConectividad controlconect = ControlConectividad();
  bool _controllerconectivity = true;
  bool _isDarkMode = false;
  String _opcion = "";
  Map<String, dynamic> _productoActual = {};
  List<ProductModel> categories = [];
  List<ProductModel> productos = [];
  List<ProductModel> productosAux = [];
  List<ProductModel> generateProducts() {
    return productos;
  }

  //Callback para retornar el producto seleccionado
  retornoProducto(List<ProductModel> producto) {
    widget.productoAgestionar(producto);
  }

  String selectedCategoryId = "0"; // ID de la categoría seleccionada
  void seleccionarCategoria(categoria) {
    categories = [];
    productos = productosAux;
    if (categoria != "Todos") {
      for (var i = 0; i < productos.length; i++) {
        if (productos[i].category == categoria) {
          categories.add(productos[i]);
        }
      }
      productos = [];
      productos = categories;
    } else {
      productos = productosAux;
    }
  }

  List<Widget> buildCategories() {
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return AssetsModel.generateCategories().map((e) {
      bool isSelected = selectedCategoryId == e.id;
      return Container(
        padding: EdgeInsets.only(left: 15, bottom: 10),
        child: ElevatedButton(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: _isDarkMode
                      ? Colors.grey.shade600
                      : MyColors.grayBackground,
                  child: e.modelo.isNotEmpty
                      ? Image.asset(
                          e.modelo,
                          height: 55,
                          width: 55,
                        )
                      : Container(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                e.category,
                style: TextStyle(
                    fontSize: 14,
                    color: _isDarkMode
                        ? Colors.white
                        : isSelected
                            ? Colors.white
                            : Colors.black38),
              ),
            ],
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Colors.white : Colors.black38,
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              isSelected
                  ? MyColors.myPurple
                  : _isDarkMode
                      ? Colors.grey.shade800
                      : Colors.white,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedCategoryId = e.id;
              seleccionarCategoria(e.category);
            });
          },
        ),
      );
    }).toList();
  }

  void _initConnectivity() async {
    // Obtiene el estado de la conectividad al inicio
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);

    // Escucha los cambios en la conectividad y actualiza el estado en consecuencia
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      _updateConnectionStatus(connectivityResult);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    setState(() {
      _controllerconectivity = connectivityResult != ConnectivityResult.none;
    });
  }

  void obtenerProductoActual(String opcion, Map<String, dynamic> producto) {
    _productoActual = producto;
    _opcion = opcion;
    print("Esta es la opcion en el seescreen: " + _opcion);
    if (_opcion == "editar") {
      for (var i = 0; i < productos.length; i++) {
        if (productos[i].id == _productoActual["id"]) {
          setState(() {
            productos[i] = ProductModel.fromJson(_productoActual);
          });
        }
      }
    } else {
      if (_opcion == "eliminar") {
        setState(() {
          productos
              .removeWhere((element) => element.id == _productoActual["id"]);
        });
      } else {
        if (_opcion == "agregar") {
          setState(() {
            productos.add(ProductModel.fromJson(_productoActual));
          });
        }
      }
    }
    retornoProducto(productos);
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    productos = widget.productos;
    productosAux = widget.productos;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: _isDarkMode ? Colors.grey.shade900 : Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new,
                  color: _isDarkMode ? Colors.white : Colors.black)),
          title: Row(
            children: [
              Icon(
                Icons.business_center,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              Text('Productos registrados',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black)),
            ],
          )),
      body: Container(
        color: _isDarkMode ? Colors.black : Colors.white,
        child: Column(
          children: [
            Container(
              color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Categorias de productos',
                      style: TextStyle(
                          fontSize: 18,
                          color: _isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    //categorias de la pantalla principal
                    child: Container(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: buildCategories(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        alignment: Alignment.center,
                        color:
                            _isDarkMode ? Colors.grey.shade900 : Colors.white,
                        child: Text(
                          'Lista de productos',
                          style: TextStyle(
                              fontSize: 18,
                              color: _isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GridView.count(
                        scrollDirection: Axis.vertical,
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(5.0),
                        children: generateProducts()
                            .map(
                              (e) => Card(
                                borderOnForeground: false,
                                color: _isDarkMode
                                    ? Colors.grey.shade800
                                    : Color.fromARGB(255, 250, 228, 231),
                                clipBehavior: Clip.antiAlias,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 0,
                                child: Container(
                                  height: 250,
                                  width: 250,
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: _controllerconectivity != false
                                            ? //Image del catalogo del producto
                                            Image.network(
                                                e.catalogo,
                                                fit: BoxFit.cover,
                                              )
                                            : //Image de verificacion de conexion
                                            Center(
                                                child: Image.asset(
                                                  "assets/icons/ic_not_signal.png",
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      //label de la categoria y valoracion del producto
                                      Row(
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                                text: e.category,
                                                style: TextStyle(
                                                    color: _isDarkMode
                                                        ? Colors.yellow
                                                        : MyColors.myPurple,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[700],
                                            size: 18,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            e.valoration.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: _isDarkMode
                                                    ? Colors.white
                                                    : Colors.black87),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      //label del titulo del producto
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: e.title,
                                            style: TextStyle(
                                                color: _isDarkMode
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontSize: 18.0)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: "Talla: ${e.talla}",
                                                style: TextStyle(
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontSize: 16.0,
                                                )),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: "Color: ${e.color}",
                                                style: TextStyle(
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontSize: 16.0,
                                                )),
                                          ),
                                        ],
                                      ),
                                      //label del precio del producto
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: "\$ ${e.price}",
                                                style: TextStyle(
                                                    color: _isDarkMode
                                                        ? Colors.white
                                                        : Colors.black87,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            width: 35,
                                            height: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              color: e.cantidad > 5
                                                  ? Colors.green.shade800
                                                  : Colors.red,
                                            ),
                                            child: Text(
                                              e.cantidad.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                var productoSeleccionado = {
                                                  'id': e.id,
                                                  'imageCatalogo': e.catalogo,
                                                  'imageModelo': e.modelo,
                                                  'cantidad': e.cantidad,
                                                  'nombre': e.title,
                                                  'descripcion': e.description,
                                                  'precio': e.price,
                                                  'talla': e.talla,
                                                  'color': e.color,
                                                  'categoria': e.category,
                                                  'valoracion': e.valoration,
                                                };
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddProductScreen(
                                                      producto:
                                                          productoSeleccionado,
                                                      productoActual:
                                                          obtenerProductoActual,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Gestionar",
                                                style: TextStyle(
                                                    color: _isDarkMode
                                                        ? Colors.white
                                                        : MyColors.myBlack),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
