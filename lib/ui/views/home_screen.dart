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
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
  ControlCompra controlc = ControlCompra();
  List<OrdersModel> pedidos = [];
  List<PurchasesModel> compras = [];
  List<ProductModel> productos = [];
  List<UsersModel> usuarios = [];
  List<ProductModel> productosGestonados = [];
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  bool _isDarkMode = false;
  bool availableFoto = false;

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
    const Color.fromARGB(255, 38, 1, 21),
    Color.fromARGB(255, 134, 7, 71),
    const Color.fromARGB(255, 89, 2, 59),
    Color.fromARGB(255, 92, 5, 62),
  ];
  //Callback para retornar el producto seleccionado
  retornoProducto(List<ProductModel> productos) {
    widget.productosGestionados(productos);
  }

  void obtenerProductoSeleccionado(List<ProductModel> producto) {
    this.productosGestonados = producto;
    setState(() {
      productos = productosGestonados;
    });
    retornoProducto(productosGestonados);
  }

  @override
  void initState() {
    super.initState();
    pedidos = widget.pedidos;
    compras = widget.compras;
    productos = widget.productos;
    usuarios = widget.usuarios;
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
                                child: Stack(children: [
                                  //Grafico interactivo donde se mostrara los ingresos mes a mes
                                  LineChart(
                                    LineChartData(
                                      // read about it in the LineChartData section
                                      backgroundColor: Colors.transparent,
                                      showingTooltipIndicators: [],
                                      clipData: FlClipData.all(),
                                      borderData: FlBorderData(
                                          show: true,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                              left: BorderSide(
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                              right: BorderSide(
                                                  color: Colors.transparent),
                                              top: BorderSide(
                                                  color: Colors.transparent))),
                                      baselineX: 0,
                                      baselineY: 0,
                                      maxX: 12,
                                      maxY: 12,
                                      minX: 0,
                                      minY: 0,
                                      lineBarsData: [
                                        LineChartBarData(
                                          show: true,
                                          shadow: Shadow(
                                              blurRadius: 2,
                                              color: MyColors.myPurple),
                                          spots: [
                                            FlSpot(0, 0),
                                            FlSpot(5, 5),
                                            FlSpot(7, 6),
                                            FlSpot(8, 4),
                                          ],
                                          isCurved: true,
                                          curveSmoothness: 0.5,
                                          barWidth: 3,
                                          showingIndicators: [0, 1, 2, 3],
                                          dashArray: [2, 2],
                                          aboveBarData: BarAreaData(
                                            show: true,
                                            cutOffY: 0,
                                            applyCutOffY: true,
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: gradientColors
                                                  .map((color) =>
                                                      color.withOpacity(0.3))
                                                  .toList(),
                                              transform: GradientRotation(90),
                                            ),
                                            spotsLine: BarAreaSpotsLine(
                                              show: true,
                                              flLineStyle: FlLine(
                                                color: _isDarkMode
                                                    ? MyColors.myBlue
                                                    : MyColors.myPurple,
                                                strokeWidth: 1,
                                              ),
                                              checkToShowSpotLine: (spot) {
                                                if (spot.x == 0 ||
                                                    spot.x == 5 ||
                                                    spot.x == 7 ||
                                                    spot.x == 8) {
                                                  return true;
                                                } else {
                                                  return false;
                                                }
                                              },
                                            ),
                                          ),
                                          belowBarData: BarAreaData(
                                            show: true,
                                            cutOffY: 0,
                                            applyCutOffY: true,
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: gradientColors
                                                  .map((color) =>
                                                      color.withOpacity(0.3))
                                                  .toList(),
                                              transform: GradientRotation(90),
                                            ),
                                            spotsLine: BarAreaSpotsLine(
                                              show: true,
                                              flLineStyle: FlLine(
                                                color: _isDarkMode
                                                    ? MyColors.myBlue
                                                    : MyColors.myPurple,
                                                strokeWidth: 1,
                                              ),
                                              checkToShowSpotLine: (spot) {
                                                if (spot.x == 0 ||
                                                    spot.x == 5 ||
                                                    spot.x == 7 ||
                                                    spot.x == 8) {
                                                  return true;
                                                } else {
                                                  return false;
                                                }
                                              },
                                            ),
                                          ),
                                          dotData: FlDotData(
                                            show: true,
                                            getDotPainter: (spot, percent,
                                                barData, index) {
                                              return FlDotCirclePainter(
                                                radius: 5,
                                                color: _isDarkMode
                                                    ? MyColors.myBlue
                                                    : MyColors.myPurple,
                                                strokeWidth: 1,
                                                strokeColor: _isDarkMode
                                                    ? MyColors.myBlue
                                                    : MyColors.myPurple,
                                              );
                                            },
                                          ),
                                          lineChartStepData: LineChartStepData(
                                            stepDirection: 12,
                                          ),
                                          preventCurveOverShooting: true,
                                          preventCurveOvershootingThreshold: 1,
                                        )
                                      ],
                                      lineTouchData: LineTouchData(
                                        enabled: true,
                                        touchTooltipData: LineTouchTooltipData(
                                          tooltipBgColor: _isDarkMode
                                              ? MyColors.myBlue
                                              : MyColors.myPurple,
                                          getTooltipItems: (touchedSpots) {
                                            return touchedSpots.map((e) {
                                              return LineTooltipItem(
                                                e.y.toString(),
                                                TextStyle(
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              );
                                            }).toList();
                                          },
                                        ),
                                        longPressDuration: Duration(
                                            milliseconds:
                                                500), //tiempo que se mantiene presionado para mostrar el tooltip
                                        getTouchedSpotIndicator:
                                            (LineChartBarData barData,
                                                List<int> spotIndexes) {
                                          return spotIndexes.map((spotIndex) {
                                            final FlSpot spot =
                                                barData.spots[spotIndex];
                                            if (spot.x == 0 ||
                                                spot.x == 5 ||
                                                spot.x == 7 ||
                                                spot.x == 8) {
                                              return TouchedSpotIndicatorData(
                                                FlLine(
                                                  color: _isDarkMode
                                                      ? MyColors.myBlue
                                                      : MyColors.myPurple,
                                                  strokeWidth: 2,
                                                ),
                                                FlDotData(
                                                  show: true,
                                                  getDotPainter: (spot, percent,
                                                      barData, index) {
                                                    return FlDotCirclePainter(
                                                      radius: 5,
                                                      color: _isDarkMode
                                                          ? MyColors.myBlue
                                                          : MyColors.myPurple,
                                                      strokeWidth: 1,
                                                      strokeColor: _isDarkMode
                                                          ? MyColors.myBlue
                                                          : MyColors.myPurple,
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              return TouchedSpotIndicatorData(
                                                FlLine(
                                                  color: Colors.transparent,
                                                ),
                                                FlDotData(
                                                  show: false,
                                                ),
                                              );
                                            }
                                          }).toList();
                                        },
                                      ),
                                      gridData: FlGridData(
                                        show: false,
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        topTitles: AxisTitles(
                                          axisNameSize: 22,
                                          axisNameWidget: Container(
                                            child: Text(
                                              "Ingresos mensuales",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                            interval: 1,
                                          ),
                                        ),
                                        bottomTitles: AxisTitles(
                                          axisNameSize: 18,
                                          axisNameWidget: Container(
                                            child: Text(
                                              "Meses del año",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                          drawBelowEverything: true,
                                          sideTitles: SideTitles(
                                            reservedSize: 30,
                                            interval: 1,
                                            showTitles: true,
                                            getTitlesWidget: (value, index) {
                                              // Aquí agregamos un segundo argumento 'meta'
                                              switch (value.toInt()) {
                                                case 0:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Ene",
                                                    ),
                                                  );
                                                case 1:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Feb",
                                                    ),
                                                  );
                                                case 2:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Mar",
                                                    ),
                                                  );
                                                case 3:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Abr",
                                                    ),
                                                  );
                                                case 4:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "May",
                                                    ),
                                                  );
                                                case 5:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Jun",
                                                    ),
                                                  );
                                                case 6:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Jul",
                                                    ),
                                                  );
                                                case 7:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Ago",
                                                    ),
                                                  );
                                                case 8:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Sep",
                                                    ),
                                                  );
                                                case 9:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Oct",
                                                    ),
                                                  );
                                                case 10:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Nov",
                                                    ),
                                                  );
                                                case 11:
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 5),
                                                    child: Text(
                                                      "Dic",
                                                    ),
                                                  );
                                                default:
                                                  return Text(
                                                      ""); // Devolvemos un widget vacío en caso de que no haya una coincidencia
                                              }
                                            },
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          axisNameSize: 18,
                                          axisNameWidget: Container(
                                            child: Text(
                                              "Ingresos",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: _isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                          drawBelowEverything: true,
                                          sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 32,
                                              interval: 1,
                                              getTitlesWidget: (value, meta) {
                                                switch (value.toInt()) {
                                                  case 0:
                                                    return Text("0.5m");
                                                  case 1:
                                                    return Text("1m");
                                                  case 2:
                                                    return Text("1.5m");
                                                  case 3:
                                                    return Text("2m");
                                                  case 4:
                                                    return Text("2.5m");
                                                  case 5:
                                                    return Text("3m");
                                                  case 6:
                                                    return Text("3.5m");
                                                  case 7:
                                                    return Text("4m");
                                                  case 8:
                                                    return Text("4.5m");
                                                  case 9:
                                                    return Text("5m");
                                                  case 10:
                                                    return Text("5.5m");
                                                  case 11:
                                                    return Text("6m");
                                                  default:
                                                    return Text("");
                                                }
                                              } // Aquí agregamos un segundo argumento 'meta'
                                              ),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                            interval: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    duration:
                                        Duration(milliseconds: 150), // Optional
                                    curve: Curves.linear, // Optional
                                  ),
                                ]),
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
                                    builder: (context) => SeeOrdersScreen(
                                          pedidos: pedidos,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
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
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    pedidos[index].estado,
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
