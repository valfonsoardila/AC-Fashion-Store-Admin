import 'package:acfashion_store/domain/controller/controllerCompra.dart';
import 'package:acfashion_store/domain/controller/controllerFavorito.dart';
import 'package:acfashion_store/domain/controller/controllerPedido.dart';
import 'package:acfashion_store/domain/controller/controllerProducto.dart';
import 'package:acfashion_store/domain/controller/controllerUserAuth.dart';
import 'package:acfashion_store/domain/controller/controllerUserPerfil.dart';
import 'package:acfashion_store/ui/home/dashboard_screen.dart';
import 'package:acfashion_store/ui/home/drawer_screen.dart';
import 'package:acfashion_store/ui/models/favorite_model.dart';
import 'package:acfashion_store/ui/models/orders_model.dart';
import 'package:acfashion_store/ui/models/purchases_model.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/models/users_model.dart';
import 'package:acfashion_store/ui/styles/my_colors.dart';
import 'package:acfashion_store/ui/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //CONTROLADORES
  ControlUserAuth controluserauth = Get.find();
  ControlUserPerfil controluserperfil = Get.put(ControlUserPerfil());
  ControlProducto controlproductos = Get.put(ControlProducto());
  ControlPedido controlpedidos = Get.put(ControlPedido());
  ControlFavoritos controlfavoritos = Get.put(ControlFavoritos());
  ControlCompra controlcompras = Get.put(ControlCompra());
  //VARIABLES DE CONTROL
  String idUsuario = '';
  String? uid;
  String msg = "";
  int tiempoDeintento = 5;
  String precioFormateado = "";
  //VARIABLES PRODUCTOS
  var idProducto = "";
  var cantidadProducto = 0;
  var catalogoProducto = "";
  var modeloProducto = "";
  var nombreProducto = "";
  var descripcionProducto = "";
  var colorProducto = "";
  var tallaProducto = "";
  var categoriaProducto = "";
  var valoracionProducto = "";
  var precioProducto = 0;
  //LISTAS
  List<Map<String, dynamic>> consultaPerfiles = [];
  List<Map<String, dynamic>> consultaProductos = [];
  List<Map<String, dynamic>> consultaFavoritos = [];
  List<Map<String, dynamic>> consultaCompras = [];
  List<Map<String, dynamic>> consultaPedidos = [];
  List<UsersModel> usuarios = [];
  List<FavoriteModel> favoritos = [];
  List<PurchasesModel> compras = [];
  List<OrdersModel> pedidos = [];
  List<ProductModel> productos = [];
  //MAPAS
  Map<String, dynamic> perfil = {};

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    //Se consulta el uid del perfil autenticado
    controluserauth.consultarUser().then((value) {
      setState(() {
        uid = controluserauth.uidValido;
        idUsuario = uid!;
      });
      cargarDatos();
    });
  }

  void cargarDatos() {
    //Se obtienen datos de perfil autenticado
    controluserperfil.obtenerperfil(idUsuario).then((value) {
      setState(() {
        msg = controluserperfil.mensajesPerfil;
      });
      if (msg == "Proceso exitoso") {
        print("Datos de perfil recibidos en MainScreen: $perfil");
        setState(() {
          perfil = controluserperfil.datosPerfil;
          print("Datos de perfil recibidos en MainScreen: $perfil");
        });
      } else {
        print("Error al cargar datos del perfil");
      }
    });
    //Se obtienen datos de usuarios
    controluserperfil.obtenerperfiles().then((value) {
      setState(() {
        msg = controluserperfil.mensajesPerfil;
      });
      if (msg == "Proceso exitoso") {
        setState(() {
          consultaPerfiles = controluserperfil.datosPerfiles;
          print("Datos de perfiles recibidos en MainScreen: $consultaPerfiles");
          if (consultaPerfiles.length > 1) {
            for (var i = 0; i < consultaPerfiles.length; i++) {
              var id = consultaPerfiles[i]['id'] ?? '';
              var foto = consultaPerfiles[i]['foto'] ?? '';
              var correo = consultaPerfiles[i]['correo'] ?? '';
              var contrasena = consultaPerfiles[i]['contrasena'] ?? '';
              var nombre = consultaPerfiles[i]['nombre'] ?? '';
              var genero = consultaPerfiles[i]['genero'] ?? '';
              var profesion = consultaPerfiles[i]['profesion'] ?? '';
              var ciudad = consultaPerfiles[i]['ciudad'] ?? '';
              var direccion = consultaPerfiles[i]['direccion'] ?? '';
              var celular = consultaPerfiles[i]['celular'] ?? '';
              usuarios.add(UsersModel(
                  id: id,
                  foto: foto,
                  correo: correo,
                  contrasena: contrasena,
                  nombre: nombre,
                  genero: genero,
                  profesion: profesion,
                  ciudad: ciudad,
                  direccion: direccion,
                  celular: celular));
            }
          } else {
            consultaPerfiles.forEach((element) {
              var id = element['id'] ?? '';
              var foto = element['foto'] ?? '';
              var correo = element['correo'] ?? '';
              var contrasena = element['contrasena'] ?? '';
              var nombre = element['nombre'] ?? '';
              var genero = element['genero'] ?? '';
              var profesion = element['profesion'] ?? '';
              var direccion = element['direccion'] ?? '';
              var ciudad = element['ciudad'] ?? '';
              var celular = element['celular'] ?? '';
              print("Foto recibida en el MainScreen: $foto");
              usuarios.add(UsersModel(
                  id: id,
                  foto: foto,
                  correo: correo,
                  contrasena: contrasena,
                  nombre: nombre,
                  genero: genero,
                  profesion: profesion,
                  ciudad: ciudad,
                  direccion: direccion,
                  celular: celular));
            });
          }
        });
      } else {
        print("Error al cargar datos del perfil");
      }
    });
    //Se obtienen datos de productos
    controlproductos.obtenerproductos().then((value) {
      setState(() {
        msg = controlproductos.mensajesProducto;
      });
      if (msg == "Proceso exitoso") {
        setState(() {
          consultaProductos = controlproductos.datosProductos;
          print(
              "Datos de productos recibidos en MainScreen: $consultaProductos");
          if (consultaProductos.length > 1) {
            for (var i = 0; i < consultaProductos.length; i++) {
              idProducto = consultaProductos[i]['id'] ?? '';
              cantidadProducto = consultaProductos[i]['cantidad'] ?? 0;
              catalogoProducto = consultaProductos[i]['catalogo'] ?? '';
              modeloProducto = consultaProductos[i]['modelo'] ?? '';
              nombreProducto = consultaProductos[i]['nombre'] ?? '';
              descripcionProducto = consultaProductos[i]['descripcion'] ?? '';
              colorProducto = consultaProductos[i]['color'] ?? '';
              tallaProducto = consultaProductos[i]['talla'] ?? '';
              categoriaProducto = consultaProductos[i]['categoria'] ?? '';
              valoracionProducto = consultaProductos[i]['valoracion'] ?? '';
              precioProducto = consultaProductos[i]['precio'] ?? 0;
              // precioFormateado =
              //     NumberFormat("#,###", "es_CO").format(precioProducto * 1000);
              productos.add(ProductModel(
                id: idProducto,
                cantidad: cantidadProducto,
                catalogo: catalogoProducto,
                modelo: modeloProducto,
                title: nombreProducto,
                color: colorProducto,
                talla: tallaProducto,
                category: categoriaProducto,
                description: descripcionProducto,
                valoration: valoracionProducto,
                price: precioProducto,
              ));
            }
          } else {
            consultaProductos.forEach((element) {
              idProducto = element['id'] ?? '';
              cantidadProducto = element['cantidad'] ?? 0;
              catalogoProducto = element['catalogo'] ?? '';
              modeloProducto = element['modelo'] ?? '';
              nombreProducto = element['nombre'] ?? '';
              descripcionProducto = element['descripcion'] ?? '';
              colorProducto = element['color'] ?? '';
              tallaProducto = element['talla'] ?? '';
              categoriaProducto = element['categoria'] ?? '';
              valoracionProducto = element['valoracion'] ?? '';
              precioProducto = element['precio'] ?? '0.0';
              // precioFormateado =
              //     NumberFormat("#,###", "es_CO").format(precioProducto * 1000);
              productos.add(ProductModel(
                id: idProducto,
                cantidad: cantidadProducto,
                catalogo: catalogoProducto,
                modelo: modeloProducto,
                title: nombreProducto,
                color: colorProducto,
                talla: tallaProducto,
                category: categoriaProducto,
                description: descripcionProducto,
                valoration: valoracionProducto,
                price: precioProducto,
              ));
            });
          }
        });
      } else {
        print("Error al cargar datos de favoritos");
      }
    });
    //Se obtienen datos de favoritos
    controlfavoritos.obtenerfavoritos(idUsuario).then((value) {
      setState(() {
        msg = controlfavoritos.mensajesFavorio;
      });
      if (msg == "Proceso exitoso") {
        setState(() {
          consultaFavoritos = controlfavoritos.datosFavoritos;
          if (consultaFavoritos.length > 1) {
            for (var i = 0; i <= consultaFavoritos.length; i++) {
              idUsuario = consultaFavoritos[i]['uid'] ?? '';
              cantidadProducto = consultaFavoritos[i]['cantidad'] ?? 0;
              catalogoProducto = consultaFavoritos[i]['imagen'] ?? '';
              nombreProducto = consultaFavoritos[i]['nombre'] ?? '';
              descripcionProducto = consultaFavoritos[i]['descripcion'] ?? '';
              colorProducto = consultaFavoritos[i]['color'] ?? '';
              tallaProducto = consultaFavoritos[i]['talla'] ?? '';
              categoriaProducto = consultaFavoritos[i]['categoria'] ?? '';
              valoracionProducto = consultaFavoritos[i]['valoracion'] ?? '';
              precioProducto = consultaFavoritos[i]['precio'] ?? '0.0';
              // precioFormateado =
              //     NumberFormat("#,###", "es_CO").format(precioProducto * 1000);
              idProducto = consultaFavoritos[i]['id'] ?? '';
              favoritos.add(FavoriteModel(
                  idUsuario,
                  cantidadProducto,
                  catalogoProducto,
                  nombreProducto,
                  descripcionProducto,
                  colorProducto,
                  tallaProducto,
                  categoriaProducto,
                  valoracionProducto,
                  precioProducto,
                  idProducto));
            }
          } else {
            consultaFavoritos.forEach((element) {
              idUsuario = element['uid'] ?? '';
              cantidadProducto = element['cantidad'] ?? 0;
              catalogoProducto = element['imagen'] ?? '';
              nombreProducto = element['nombre'] ?? '';
              descripcionProducto = element['descripcion'] ?? '';
              colorProducto = element['color'] ?? '';
              tallaProducto = element['talla'] ?? '';
              categoriaProducto = element['categoria'] ?? '';
              valoracionProducto = element['valoracion'] ?? '';
              precioProducto = element['precio'] ?? '0.0';
              // precioFormateado =
              //     NumberFormat("#,###", "es_CO").format(precioProducto * 1000);
              idProducto = element['id'] ?? '';
              favoritos.add(FavoriteModel(
                  idUsuario,
                  cantidadProducto,
                  catalogoProducto,
                  nombreProducto,
                  descripcionProducto,
                  colorProducto,
                  tallaProducto,
                  categoriaProducto,
                  valoracionProducto,
                  precioProducto,
                  idProducto));
            });
          }
        });
      } else {
        print("Error al cargar datos de favoritos");
      }
    });
    //Se obtienen datos de compras
    controlcompras.obtenerCompras().then((value) {
      setState(() {
        msg = controlcompras.mensajesCompra;
      });
      if (msg == "Proceso exitoso") {
        setState(() {
          consultaCompras = controlcompras.datosCompras;
          print("Datos de compras recibidos en MainScreen: $consultaCompras");
          if (consultaCompras.length > 1) {
            for (var i = 0; i < consultaCompras.length; i++) {
              var uid = consultaFavoritos[i]['uid'] ?? '';
              var iduser = consultaFavoritos[i]['iduser'] ?? '';
              var idpedido = consultaFavoritos[i]['idpedido'] ?? '';
              var cantidad = consultaFavoritos[i]['cantidad'] ?? 0;
              var imagen = consultaFavoritos[i]['imagen'] ?? '';
              var titulo = consultaFavoritos[i]['titulo'] ?? '';
              var descripcion = consultaFavoritos[i]['descripcion'] ?? '';
              var color = consultaFavoritos[i]['color'] ?? '';
              var talla = consultaFavoritos[i]['talla'] ?? '';
              var categoria = consultaFavoritos[i]['categoria'] ?? '';
              var valoracion = consultaFavoritos[i]['valoracion'] ?? '';
              var precio = consultaFavoritos[i]['precio'] ?? 0;
              // precioFormateado =
              //     NumberFormat("#,###", "es_CO").format(precio * 1000);
              compras.add(PurchasesModel(
                uid,
                iduser,
                idpedido,
                cantidad,
                imagen,
                titulo,
                descripcion,
                color,
                talla,
                categoria,
                valoracion,
                precio,
              ));
            }
          } else {
            consultaCompras.forEach((element) {
              var uid = element['uid'] ?? '';
              var iduser = element['iduser'] ?? '';
              var idpedido = element['idpedido'] ?? '';
              var cantidad = element['cantidad'] ?? 0;
              var imagen = element['imagen'] ?? '';
              var titulo = element['titulo'] ?? '';
              var descripcion = element['descripcion'] ?? '';
              var color = element['color'] ?? '';
              var talla = element['talla'] ?? '';
              var categoria = element['categoria'] ?? '';
              var valoracion = element['valoracion'] ?? '';
              var precio = element['precio'] ?? '0.0';
              // precioFormateado =
              //     NumberFormat("#,###", "es_CO").format(precio * 1000);
              compras.add(PurchasesModel(
                uid,
                iduser,
                idpedido,
                cantidad,
                imagen,
                titulo,
                descripcion,
                color,
                talla,
                categoria,
                valoracion,
                precio,
              ));
            });
          }
          print("Unica compra recibida en el main screen: $compras");
        });
      } else {
        print("Error al cargar datos de compras");
      }
    });
    //Se obtienen datos de pedidos
    controlpedidos.consultarPedido().then((value) => {
          setState(() {
            msg = controlpedidos.mensajesPedido;
          }),
          if (msg == "Proceso exitoso")
            {
              setState(() {
                consultaPedidos = controlpedidos.datosPedidos;
                print(
                    "Datos de pedidos recibidos en MainScreen: $consultaPedidos");
                if (consultaPedidos.length > 1) {
                  for (var i = 0; i < consultaPedidos.length; i++) {
                    var uid = consultaPedidos[i]['uid'] ?? '';
                    var iduser = consultaPedidos[i]['iduser'] ?? '';
                    var nombre = consultaPedidos[i]['nombre'] ?? '';
                    var correo = consultaPedidos[i]['correo'] ?? '';
                    var telefono = consultaPedidos[i]['celular'] ?? '';
                    var direccion = consultaPedidos[i]['direccion'] ?? '';
                    var foto = consultaPedidos[i]['foto'] ?? '';
                    var cantidad = consultaPedidos[i]['cantidad'] ?? 0;
                    var total = consultaPedidos[i]['total'] ?? '0.0';
                    var metodoPago = consultaPedidos[i]['metodoPago'] ?? '';
                    var fechaDeCompra = consultaPedidos[i]['fechaCompra'] ?? '';
                    var horaDeCompra = consultaPedidos[i]['horaCompra'] ?? '';
                    var estado = consultaPedidos[i]['estadoEntrega'] ?? '';
                    var tiempoDeEntrega =
                        consultaPedidos[i]['tiempoDeEntrega'] ?? '';
                    print("Celular recibido: $telefono");
                    print("Estado de entrega recibido: $estado");
                    pedidos.add(
                      OrdersModel(
                        uid,
                        iduser,
                        nombre,
                        correo,
                        telefono,
                        foto,
                        direccion,
                        cantidad,
                        total,
                        metodoPago,
                        fechaDeCompra,
                        horaDeCompra,
                        estado,
                        tiempoDeEntrega,
                      ),
                    );
                  }
                } else {
                  consultaPedidos.forEach((element) {
                    var uid = element['uid'] ?? '';
                    var iduser = element['iduser'] ?? '';
                    var nombre = element['nombre'] ?? '';
                    var correo = element['correo'] ?? '';
                    var telefono = element['celular'] ?? '';
                    var direccion = element['direccion'] ?? '';
                    var foto = element['foto'] ?? '';
                    var cantidad = element['cantidad'] ?? 0;
                    var total = element['total'] ?? 0;
                    var metodoPago = element['metodoPago'] ?? '';
                    var fechaDeCompra = element['fechaCompra'] ?? '';
                    var horaDeCompra = element['horaCompra'] ?? '';
                    var estado = element['estadoEntrega'] ?? '';
                    var tiempoDeEntrega = element['tiempoEntrega'] ?? '';
                    pedidos.add(
                      OrdersModel(
                        uid,
                        iduser,
                        nombre,
                        correo,
                        telefono,
                        foto,
                        direccion,
                        cantidad,
                        total,
                        metodoPago,
                        fechaDeCompra,
                        horaDeCompra,
                        estado,
                        tiempoDeEntrega,
                      ),
                    );
                  });
                }
              })
            }
        });
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
      backgroundColor: _isDarkMode != false ? Colors.black : Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: Future.delayed(
              Duration(seconds: 2)), //Establece el tiempo de carga
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: MyColors.myPurple,
                    backgroundColor: Colors.purple[400],
                  ),
                  Text(
                    "Cargando...",
                    style: TextStyle(
                      color: MyColors.myPurple,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              );
            } else {
              if (snapshot.hasError) {
                final theme = Provider.of<ThemeChanger>(context);
                var temaActual = theme.getTheme();
                if (temaActual == ThemeData.dark()) {
                  _isDarkMode = true;
                } else {
                  _isDarkMode = false;
                }
                return Container(
                  color: _isDarkMode != false ? Colors.black : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.network_check,
                            color: _isDarkMode != false
                                ? _isDarkMode != false
                                    ? Colors.red
                                    : Color.fromARGB(255, 231, 30, 15)
                                : Color.fromARGB(255, 231, 30, 15),
                          ),
                          Icon(
                            Icons.error,
                            color: _isDarkMode != false
                                ? _isDarkMode != false
                                    ? Colors.red
                                    : Color.fromARGB(255, 231, 30, 15)
                                : Color.fromARGB(255, 231, 30, 15),
                          ),
                        ],
                      ),
                      Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(
                          color: _isDarkMode != false
                              ? _isDarkMode != false
                                  ? Colors.red
                                  : Color.fromARGB(255, 231, 30, 15)
                              : Color.fromARGB(255, 231, 30, 15),
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        "Verifique su conexión a internet",
                        style: TextStyle(
                          color: _isDarkMode != false
                              ? _isDarkMode != false
                                  ? Colors.red
                                  : Color.fromARGB(255, 231, 30, 15)
                              : Color.fromARGB(255, 231, 30, 15),
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.black,
                        backgroundColor: MyColors.myBlack,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => MainScreen());
                        },
                        child: Text(
                          "Intentar de nuevo",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                if (perfil.isNotEmpty) {
                  print("Perfil: $perfil");
                  return Scaffold(
                    body: Stack(
                      children: [
                        DrawerScreen(
                          uid: perfil['id'],
                          nombre: perfil['nombre'],
                          correo: perfil['correo'],
                          contrasena: perfil['contrasena'],
                          celular: perfil['celular'],
                          direccion: perfil['direccion'],
                          foto: perfil['foto'],
                          profesion: perfil['profesion'],
                        ),
                        DashboardScreen(
                          id: perfil['id'],
                          nombre: perfil['nombre'],
                          correo: perfil['correo'],
                          contrasena: perfil['contrasena'],
                          celular: perfil['celular'],
                          direccion: perfil['direccion'],
                          foto: perfil['foto'],
                          profesion: perfil['profesion'],
                          usuarios: usuarios,
                          productos: productos,
                          favoritos: favoritos,
                          compras: compras,
                          pedidos: pedidos,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: _isDarkMode != false ? Colors.black : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: _isDarkMode != false
                              ? Colors.red
                              : Color.fromARGB(255, 231, 30, 15),
                        ),
                        Text(
                          "Error desconocido",
                          style: TextStyle(
                            color: _isDarkMode != false
                                ? Colors.red
                                : Color.fromARGB(255, 231, 30, 15),
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          "Por favor vuelva a ingresar",
                          style: TextStyle(
                            color: _isDarkMode != false
                                ? Colors.red
                                : Color.fromARGB(255, 231, 30, 15),
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed("/login");
                          },
                          child: Text(
                            "Volver",
                            style: TextStyle(
                              color: _isDarkMode != false
                                  ? Colors.red
                                  : Color.fromARGB(255, 231, 30, 15),
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }
}
