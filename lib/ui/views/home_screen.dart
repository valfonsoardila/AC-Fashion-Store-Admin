import 'dart:math';
import 'package:acfashion_store/domain/controller/controllerCompra.dart';
import 'package:acfashion_store/ui/auth/perfil.dart';
import 'package:acfashion_store/ui/models/orders_model.dart';
import 'package:acfashion_store/ui/models/product_model.dart';
import 'package:acfashion_store/ui/models/purchases_model.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/models/users_model.dart';
import 'package:acfashion_store/ui/styles/my_colors.dart';
import 'package:acfashion_store/ui/views/add_product_screen.dart';
import 'package:acfashion_store/ui/views/orders_screen.dart';
import 'package:acfashion_store/ui/views/summary_views/see_orders_screen.dart';
import 'package:acfashion_store/ui/views/summary_views/see_products_screens.dart';
import 'package:acfashion_store/ui/views/summary_views/see_statistics_screen.dart';
import 'package:acfashion_store/ui/views/summary_views/see_users_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final pedidos;
  final compras;
  final productos;
  final usuarios;
  final productosGestionados;
  HomeScreen(
      {super.key,
      this.pedidos,
      this.compras,
      this.productos,
      this.usuarios,
      this.productosGestionados});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> data;
  late TooltipBehavior _tooltip;
  double min = 0;
  double max = 10000000;
  double valorVenta = 0;
  List<String> Meses = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic'
  ];

  ControlCompra controlc = ControlCompra();
  List<OrdersModel> pedidos = [];
  List<PurchasesModel> compras = [];
  List<ProductModel> productos = [];
  List<UsersModel> usuarios = [];
  List<ProductModel> productosGestonados = [];
  bool _isDarkMode = false;
  bool availableFoto = false;
  //Lista de colores para los cards
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  List<Color> listaColoresLight = [
    const Color.fromARGB(255, 217, 48, 93),
    const Color.fromARGB(255, 140, 20, 120),
    const Color.fromARGB(255, 126, 15, 140),
    const Color.fromARGB(255, 172, 20, 120),
    const Color.fromARGB(255, 217, 37, 126),
    const Color.fromARGB(255, 140, 13, 96),
  ];
  List<Color> listaColoresDark = [
    Color.fromARGB(255, 104, 3, 30),
    Color.fromARGB(255, 94, 4, 79),
    Color.fromARGB(255, 83, 4, 94),
    Color.fromARGB(255, 107, 5, 71),
    const Color.fromARGB(255, 89, 2, 34),
    Color.fromARGB(255, 56, 1, 31),
    Color.fromARGB(255, 134, 7, 71),
    const Color.fromARGB(255, 89, 2, 59),
    Color.fromARGB(255, 92, 5, 62),
  ];
  //Callback para retornar el producto seleccionado
  retornoProducto(List<ProductModel> productos) {
    widget.productosGestionados(productos);
  }

  //Callback para obtener el producto seleccionado
  void obtenerProductoSeleccionado(List<ProductModel> producto) {
    this.productosGestonados = producto;
    setState(() {
      productos = productosGestonados;
    });
    retornoProducto(productosGestonados);
  }

  double obtenerSumatoriaVentas(List<OrdersModel> pedidos) {
    double sumatoria = 0;
    String mes = '';
    for (var i = 0; i < pedidos.length; i++) {
      mes = pedidos[i].fechaDeCompra.substring(3, 5);
      if (mes == '01') {
        data[0] = _ChartData('Ene', data[0].y + pedidos[i].total);
        sumatoria = sumatoria + pedidos[i].total;
      } else {
        if (mes == '02') {
          data[1] = _ChartData('Feb', data[1].y + pedidos[i].total);
          sumatoria = sumatoria + pedidos[i].total;
        } else {
          if (mes == '03') {
            data[2] = _ChartData('Mar', data[2].y + pedidos[i].total);
            sumatoria = sumatoria + pedidos[i].total;
          } else {
            if (mes == '04') {
              data[3] = _ChartData('Abr', data[3].y + pedidos[i].total);
              sumatoria = sumatoria + pedidos[i].total;
            } else {
              if (mes == '05') {
                data[4] = _ChartData('May', data[4].y + pedidos[i].total);
                sumatoria = sumatoria + pedidos[i].total;
              } else {
                if (mes == '06') {
                  data[5] = _ChartData('Jun', data[5].y + pedidos[i].total);
                  sumatoria = sumatoria + pedidos[i].total;
                } else {
                  if (mes == "07") {
                    data[6] = _ChartData('Jul', data[6].y + pedidos[i].total);
                    sumatoria = sumatoria + pedidos[i].total;
                  } else {
                    if (mes == '08') {
                      data[7] = _ChartData('Ago', data[7].y + pedidos[i].total);
                      sumatoria = sumatoria + pedidos[i].total;
                    } else {
                      if (mes == '09') {
                        data[8] =
                            _ChartData('Sep', data[8].y + pedidos[i].total);
                        sumatoria = sumatoria + pedidos[i].total;
                      } else {
                        if (mes == '10') {
                          data[9] =
                              _ChartData('Oct', data[9].y + pedidos[i].total);
                          sumatoria = sumatoria + pedidos[i].total;
                        } else {
                          if (mes == '11') {
                            data[10] = _ChartData(
                                'Nov', data[10].y + pedidos[i].total);
                            sumatoria = sumatoria + pedidos[i].total;
                          } else {
                            if (mes == '12') {
                              data[11] = _ChartData(
                                  'Dic', data[11].y + pedidos[i].total);
                              sumatoria = sumatoria + pedidos[i].total;
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    print(mes);
    print(sumatoria.toString());
    return sumatoria;
  }

  @override
  void initState() {
    super.initState();
    pedidos = widget.pedidos;
    compras = widget.compras;
    productos = widget.productos;
    usuarios = widget.usuarios;
    data = [
      _ChartData('Ene', valorVenta),
      _ChartData('Feb', 0),
      _ChartData('Mar', 0),
      _ChartData('Abr', 0),
      _ChartData('May', 0),
      _ChartData('Jun', 0),
      _ChartData('Jul', 0),
      _ChartData('Ago', 0),
      _ChartData('Sep', 0),
      _ChartData('Oct', 0),
      _ChartData('Nov', 0),
      _ChartData('Dic', 0),
    ];
    _tooltip = TooltipBehavior(enable: true);
    valorVenta = obtenerSumatoriaVentas(pedidos);
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
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: _isDarkMode
                      ? const Color.fromARGB(255, 28, 27, 27)
                      : const Color.fromARGB(255, 245, 243, 243),
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text('Panel de administracion',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: _isDarkMode
                          ? const Color.fromARGB(255, 28, 27, 27)
                          : const Color.fromARGB(255, 245, 243, 243),
                      padding: EdgeInsets.only(
                          top: 10, left: 20, bottom: 20, right: 20),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'inicio',
                            style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.98,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SeeStatisticsScreen()),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Crecimiento de negocio",
                                  style: TextStyle(
                                      color: _isDarkMode
                                          ? Colors.white
                                          : MyColors.myPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: _isDarkMode
                                      ? Colors.white
                                      : MyColors.myPurple,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _isDarkMode
                                    ? listaColoresDark[Random()
                                        .nextInt(listaColoresDark.length)]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              //Cambiar el tamaño del grafico
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 0.35,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topLeft,
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      title: ChartTitle(
                                          text: 'Flujo de ventas: $valorVenta'),
                                      legend: Legend(isVisible: false),
                                      primaryXAxis: CategoryAxis(
                                        labelPlacement: LabelPlacement.onTicks,
                                        majorGridLines:
                                            MajorGridLines(width: 0),
                                        name: 'Meses',
                                        title: AxisTitle(text: 'Meses'),
                                        axisLine: AxisLine(width: 0),
                                        arrangeByIndex: true,
                                        labelIntersectAction:
                                            AxisLabelIntersectAction.rotate45,
                                      ),
                                      primaryYAxis: NumericAxis(
                                          name: 'Ingresos',
                                          title: AxisTitle(text: 'Ingresos'),
                                          minimum: min,
                                          maximum: max,
                                          interval: max / 10),
                                      series: <ChartSeries<dynamic, String>>[
                                        AreaSeries<dynamic, String>(
                                          dataSource: data,
                                          xValueMapper: (dynamic data, _) =>
                                              data.x,
                                          yValueMapper: (dynamic data, _) =>
                                              data.y,
                                          name: 'Gold',
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: gradientColors,
                                          ),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.3),
                                        )
                                      ])),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.98,
                      height: MediaQuery.of(context).size.height * 0.3,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeeOrdersScreen(
                                          pedidos: pedidos,
                                          productos: productos,
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Pedidos recientes",
                                  style: TextStyle(
                                      color: _isDarkMode
                                          ? Colors.white
                                          : MyColors.myPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: _isDarkMode
                                      ? Colors.white
                                      : MyColors.myPurple,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                          //Lista de pedidos cargadas
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: pedidos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color colorFondo = _isDarkMode
                                      ? listaColoresDark[Random()
                                          .nextInt(listaColoresDark.length)]
                                      : listaColoresLight[Random()
                                          .nextInt(listaColoresLight.length)];
                                  return Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: colorFondo,
                                      child: InkWell(
                                        onTap: () {
                                          var productosPedido = [];
                                          controlc
                                              .filtrarCompras(pedidos[index].id)
                                              .then((value) {
                                            productosPedido =
                                                controlc.datosCompras;
                                            print("Productos ya filtrados: " +
                                                productosPedido.toString());
                                            if (productosPedido.isNotEmpty) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdersScreen(
                                                          pedido:
                                                              pedidos[index],
                                                          productosPedido:
                                                              productosPedido,
                                                          productos: productos,
                                                        )),
                                              );
                                            }
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 5,
                                              right: 5,
                                              bottom: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Pedido ${pedidos.indexOf(pedidos[index]) + 1}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    " - ${pedidos[index].fechaDeCompra}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    " - ${pedidos[index].horaDeCompra}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      pedidos[index].foto != ''
                                                          ? CircleAvatar(
                                                              radius: 12,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      pedidos[index]
                                                                          .foto),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 12,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                "assets/images/user.png",
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        pedidos[index].nombre,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                      'Estado: ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      pedidos[index].estado,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Cantidad de productos: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "${pedidos[index].cantidad}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.98,
                      height: MediaQuery.of(context).size.height * 0.3,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeeProductsScreen(
                                          productos: productos,
                                          productoAgestionar:
                                              obtenerProductoSeleccionado,
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Inventario de productos",
                                  style: TextStyle(
                                      color: _isDarkMode
                                          ? Colors.white
                                          : MyColors.myPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: _isDarkMode
                                      ? Colors.white
                                      : MyColors.myPurple,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: productos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color colorFondo = _isDarkMode
                                      ? listaColoresDark[Random()
                                          .nextInt(listaColoresDark.length)]
                                      : listaColoresLight[Random()
                                          .nextInt(listaColoresLight.length)];
                                  return Container(
                                    height: 90,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: colorFondo,
                                      child: InkWell(
                                        onTap: () {
                                          var productoSeleccionado =
                                              productos[index];
                                          var productoMapeado = {
                                            "id": productoSeleccionado.id,
                                            "cantidad":
                                                productoSeleccionado.cantidad,
                                            "imageCatalogo":
                                                productoSeleccionado.catalogo,
                                            "imageModelo":
                                                productoSeleccionado.modelo,
                                            "nombre":
                                                productoSeleccionado.title,
                                            "color": productoSeleccionado.color,
                                            "talla": productoSeleccionado.talla,
                                            "categoria":
                                                productoSeleccionado.category,
                                            "descripcion": productoSeleccionado
                                                .description,
                                            "valoracion":
                                                productoSeleccionado.valoration,
                                            "precio":
                                                productoSeleccionado.price,
                                          };
                                          print(productoSeleccionado);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddProductScreen(
                                                producto: productoMapeado,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 5,
                                              right: 5,
                                              bottom: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Producto ${productos.indexOf(productos[index]) + 1}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        " ${productos[index].valoration}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Cantidad ${productos[index].cantidad}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                productos[index]
                                                                    .catalogo),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        productos[index].title,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Talla: ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    productos[index].talla,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Categoria del producto: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "${productos[index].category}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.98,
                      height: MediaQuery.of(context).size.height * 0.3,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeeUsersScreen(
                                          usuarios: usuarios,
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Usuarios registrados",
                                  style: TextStyle(
                                    color: _isDarkMode
                                        ? Colors.white
                                        : MyColors.myPurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: _isDarkMode
                                      ? Colors.white
                                      : MyColors.myPurple,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            // Use Expanded here to make the ListView take all available space
                            child: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: usuarios.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color colorFondo = _isDarkMode
                                      ? listaColoresDark[Random()
                                          .nextInt(listaColoresDark.length)]
                                      : listaColoresLight[Random()
                                          .nextInt(listaColoresLight.length)];
                                  return Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: colorFondo,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Perfil(
                                                perfil: usuarios[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                            bottom: 5,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Usuario ${usuarios.indexOf(usuarios[index]) + 1}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    " - Tel: ${usuarios[index].celular}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  usuarios[index].foto != ''
                                                      ? CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            usuarios[index]
                                                                .foto,
                                                          ),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:
                                                              AssetImage(
                                                            "assets/images/user.png",
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    usuarios[index].nombre,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
