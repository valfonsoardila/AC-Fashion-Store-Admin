import 'package:acfashion_store/domain/controller/controllerCompra.dart';
import 'package:acfashion_store/domain/controller/controllerNotificacion.dart';
import 'package:acfashion_store/domain/controller/controllerPedido.dart';
import 'package:acfashion_store/domain/controller/controllerProducto.dart';
import 'package:acfashion_store/ui/models/orders_model.dart';
import 'package:acfashion_store/ui/models/product_model.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/styles/my_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  final pedido;
  final productosPedido;
  final productos;
  OrdersScreen({super.key, this.pedido, this.productosPedido, this.productos});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  ControlProducto controlproducto = ControlProducto();
  ControlCompra controlcompra = ControlCompra();
  ControlPedido controlpedido = ControlPedido();
  ControlNotificacion controlnotificacion = ControlNotificacion();
  bool _isDarkMode = false;
  List<OrdersModel> _pedido = [];
  List<ProductModel> _productosPedido = [];
  List<ProductModel> _productosExistentes = [];
  String selectedId = "0";

  bool _controllerconectivity = false;
  String getFormattedTime() {
    var now = DateTime.now();
    var formattedTime = DateFormat('h:mm a').format(now);
    return formattedTime;
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

  List<Widget> buildProductsOrders() {
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return _productosPedido.map((e) {
      return Container(
        child: Card(
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
            height: 300,
            width: 200,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Row(
                        children: [
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
                    )
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
                          color: _isDarkMode ? Colors.white : Colors.black87,
                          fontSize: 18.0)),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Talla: ${e.talla}",
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black87,
                            fontSize: 16.0,
                          )),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Color: ${e.color}",
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black87,
                            fontSize: 16.0,
                          )),
                    ),
                  ],
                ),
                //label del precio del producto
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "\$ ${e.price.toString()}",
                          style: TextStyle(
                              color:
                                  _isDarkMode ? Colors.white : Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  void cargarProductos() {
    if (widget.pedido != null &&
        widget.productosPedido != null &&
        widget.productos != null) {
      _pedido.add(widget.pedido);
      _productosExistentes = widget.productos;
      widget.productosPedido.forEach((element) {
        var producto = {
          'id': element['idproducto'],
          'cantidad': element['cantidad'],
          'catalogo': element['imagen'],
          'modelo': element['imagen'],
          'nombre': element['titulo'],
          'color': element['color'],
          'talla': element['talla'],
          'categoria': element['categoria'],
          'descripcion': element['descripcion'],
          'valoracion': element['valoracion'],
          'precio': element['precio'],
        };
        _productosPedido.add(ProductModel.fromJson(producto));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    cargarProductos();
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
      resizeToAvoidBottomInset: true,
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          'Gestionar pedido',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: _isDarkMode ? Colors.white : Colors.black),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(milliseconds: 100));
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Productos del pedido',
                      style: TextStyle(
                          fontSize: 18,
                          color: _isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 300,
                    //categorias de la pantalla principal
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: buildProductsOrders(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Información del pedido',
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    _isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Datos de cliente',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Nombre: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].nombre,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Correo: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].correo,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Teléfono: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].telefono,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Dirección: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].direccion,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Datos de pedido',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Cantidad: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].cantidad.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${_pedido[0].total.toString()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Método de pago: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].metodoPago,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Fecha de compra: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].fechaDeCompra,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Hora de compra: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].horaDeCompra,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Estado: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _pedido[0].estado == "Pendiente"
                                          ? Colors.amber
                                          : _pedido[0].estado == "Enviado"
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    child: Text(
                                      _pedido[0].estado,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Tiempo de entrega: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _pedido[0].tiempoDeEntrega,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      var notificacion = {
                                        'iduser': _pedido[0].idUser,
                                        'titulo': "Pedido enviado",
                                        'descripcion':
                                            "Su pedido ha sido enviado exitosamente, Gracias por su compra.",
                                        'tiempoEntrega':
                                            _pedido[0].tiempoDeEntrega,
                                        'estado': "Enviado",
                                        'hora': '${getFormattedTime()}',
                                        'fecha':
                                            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                      };
                                      for (int i = 0;
                                          i < _productosPedido.length;
                                          i++) {
                                        if (_productosExistentes[i].id ==
                                            _productosPedido[i].id) {
                                          var producto = {
                                            'id': _productosPedido[i].id,
                                            'cantidad': _productosExistentes[i]
                                                    .cantidad -
                                                _productosPedido[i].cantidad,
                                            'catalogo':
                                                _productosPedido[i].catalogo,
                                            'modelo':
                                                _productosPedido[i].modelo,
                                            'nombre': _productosPedido[i].title,
                                            'color': _productosPedido[i].color,
                                            'talla': _productosPedido[i].talla,
                                            'categoria':
                                                _productosPedido[i].category,
                                            'descripcion':
                                                _productosPedido[i].description,
                                            'valoracion':
                                                _productosPedido[i].valoration,
                                            'precio': _productosPedido[i].price,
                                          };
                                          controlproducto.actualizarproducto(
                                              producto,
                                              _productosPedido[i].catalogo,
                                              _productosPedido[i].modelo);
                                        }
                                      }
                                      var pedido = {
                                        'id': _pedido[0].id,
                                        'idUser': _pedido[0].idUser,
                                        'nombre': _pedido[0].nombre,
                                        'correo': _pedido[0].correo,
                                        'telefono': _pedido[0].telefono,
                                        'direccion': _pedido[0].direccion,
                                        'cantidad': _pedido[0].cantidad,
                                        'total': _pedido[0].total,
                                        'metodoPago': _pedido[0].metodoPago,
                                        'fechaDeCompra':
                                            _pedido[0].fechaDeCompra,
                                        'horaDeCompra': _pedido[0].horaDeCompra,
                                        'estado': "Enviado",
                                        'tiempoDeEntrega':
                                            _pedido[0].tiempoDeEntrega,
                                      };
                                      controlpedido.actualizarPedido(
                                          _pedido[0].id, pedido);
                                      _pedido.remove(_pedido[0]);
                                      controlnotificacion
                                          .actualizarNotificacion(notificacion)
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                    child: Container(
                                      child: Text(
                                        "Enviar📦",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.myPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      DateTime now = DateTime.now();
                                      var notificacion = {
                                        'iduser': _pedido[0].idUser,
                                        'titulo': "Su Pedido se ha retrasado",
                                        'descripcion':
                                            "Su pedido se ha retrasado, lamentamos los inconvenientes. Estamos trabajando para solucionarlo.",
                                        'tiempoEntrega':
                                            _pedido[0].tiempoDeEntrega,
                                        'estado': "Retrasado",
                                        'hora': DateFormat('HH:mm').format(now),
                                        'fecha': DateFormat('dd-MM-yyyy')
                                            .format(now),
                                      };
                                      var pedido = {
                                        'id': _pedido[0].id,
                                        'idUser': _pedido[0].idUser,
                                        'nombre': _pedido[0].nombre,
                                        'correo': _pedido[0].correo,
                                        'telefono': _pedido[0].telefono,
                                        'direccion': _pedido[0].direccion,
                                        'cantidad': _pedido[0].cantidad,
                                        'total': _pedido[0].total,
                                        'metodoPago': _pedido[0].metodoPago,
                                        'fechaDeCompra':
                                            _pedido[0].fechaDeCompra,
                                        'horaDeCompra': _pedido[0].horaDeCompra,
                                        'estado': "Enviado",
                                        'tiempoDeEntrega':
                                            _pedido[0].tiempoDeEntrega,
                                      };
                                      controlpedido.actualizarPedido(
                                          _pedido[0].id, pedido);
                                      controlnotificacion
                                          .actualizarNotificacion(notificacion)
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                    child: Container(
                                        child: Text(
                                      "Marcar retraso⌚",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.myPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      DateTime now = DateTime.now();
                                      var notificacion = {
                                        'iduser': _pedido[0].idUser,
                                        'titulo': "Su Pedido ha sido cancelado",
                                        'descripcion':
                                            "Su pedido ha sido cancelado, Estamos trabajando para solucionarlo.",
                                        'tiempoEntrega':
                                            _pedido[0].tiempoDeEntrega,
                                        'estado': "Cancelado",
                                        'hora': DateFormat('HH:mm').format(now),
                                        'fecha': DateFormat('dd-MM-yyyy')
                                            .format(now),
                                      };
                                      _pedido.remove(_pedido[0]);
                                      controlnotificacion
                                          .actualizarNotificacion(notificacion)
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                    child: Container(
                                        child: Text(
                                      "Eliminar❌",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.myPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
