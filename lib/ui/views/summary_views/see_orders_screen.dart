import 'package:acfashion_store/domain/controller/controllerCompra.dart';
import 'package:acfashion_store/ui/models/orders_model.dart';
import 'package:acfashion_store/ui/models/product_model.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/views/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeOrdersScreen extends StatefulWidget {
  final pedidos;
  final productos;
  SeeOrdersScreen({super.key, this.pedidos, this.productos});

  @override
  State<SeeOrdersScreen> createState() => _SeeOrdersScreenState();
}

class _SeeOrdersScreenState extends State<SeeOrdersScreen> {
  ControlCompra controlc = ControlCompra();
  bool _isDarkMode = false;
  List<OrdersModel> pedidos = [];
  List<ProductModel> productos = [];
  @override
  void initState() {
    super.initState();
    pedidos = widget.pedidos;
    productos = widget.productos;
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
                Icons.shopping_cart,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              Text('Pedidos realizados',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black)),
            ],
          )),
      body: Container(
        color: _isDarkMode ? Colors.black : Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pedidos.length,
            itemBuilder: (BuildContext context, int index) {
              Color colorFondo = _isDarkMode
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.8);
              return Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: colorFondo,
                  child: InkWell(
                    onTap: () {
                      var productosPedido = [];
                      controlc.filtrarCompras(pedidos[index].id).then((value) {
                        productosPedido = controlc.datosCompras;
                        if (productosPedido.isNotEmpty) {
                          print("Productos filtrados: " +
                              productosPedido.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrdersScreen(
                                      pedido: pedidos[index],
                                      productosPedido: productosPedido,
                                      productos: productos,
                                    )),
                          );
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pedido ${pedidos.indexOf(pedidos[index]) + 1}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                " - ${pedidos[index].fechaDeCompra}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                " - ${pedidos[index].horaDeCompra}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              pedidos[index].foto != ''
                                  ? CircleAvatar(
                                      radius: 12,
                                      backgroundImage:
                                          NetworkImage(pedidos[index].foto),
                                    )
                                  : CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
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
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                pedidos[index].estado,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
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
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                "${pedidos[index].cantidad}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black),
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
    );
  }
}
