import 'package:acfashion_store/domain/controller/controllerUserAuth.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isDarkMode = false;
  bool _controllerconectivity = false;
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

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    //ControlUser controlu = Get.find();
    //ControlUserFirebase controlfb = Get.find();
    ControlUserAuth controlua = Get.find();
    TextEditingController nombre = TextEditingController();
    TextEditingController user = TextEditingController();
    TextEditingController pass = TextEditingController();
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }

    return Scaffold(
      // backgroundColor: _isDarkMode != false ? Colors.black : Colors.white,
      // appBar: AppBar(
      //     backgroundColor: _isDarkMode != false ? Colors.black : Colors.white,
      //     leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back_ios_new,
      //         color: _isDarkMode != false ? Colors.white : Colors.black,
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     )),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            shape: BoxShape
                .rectangle, // No se necesita, pero puedes probar con otras formas
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            color: Colors.grey.shade900.withOpacity(0.75),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 140,
              ),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        25), // Ajusta el valor según el radio que desees
                    color: _isDarkMode != false
                        ? Colors.black
                        : Colors.grey.shade100.withOpacity(0.8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: _isDarkMode != false
                                ? Colors.white
                                : Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]),
                      Icon(Icons.person,
                          color: _isDarkMode != false
                              ? Colors.white
                              : Colors.black,
                          size: 40),
                      Text(
                        "Crear una Cuenta",
                        style: TextStyle(
                            color: _isDarkMode != false
                                ? Colors.white
                                : Colors.black,
                            fontSize: 33),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(children: [
                          TextFormField(
                            controller: nombre,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 254, 12, 131)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: _isDarkMode != false
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'Nombre completo',
                              labelStyle: TextStyle(
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(Icons.supervised_user_circle,
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: user,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 254, 12, 131)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: _isDarkMode != false
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'Correo electrónico',
                              labelStyle: TextStyle(
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(Icons.email,
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pass,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 254, 12, 131)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: _isDarkMode != false
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black),
                              prefixIcon: Icon(Icons.lock,
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    color: _isDarkMode != false
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Color.fromARGB(255, 124, 12, 131),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _initConnectivity();
                                      if (_controllerconectivity == true) {
                                        if (nombre.text.isEmpty &&
                                            user.text.isEmpty &&
                                            pass.text.isEmpty) {
                                          Get.snackbar(
                                            "Por favor llene todos los campos",
                                            controlua.mensajesUser,
                                            duration: Duration(seconds: 4),
                                          );
                                        } else if (nombre.text.isEmpty) {
                                          Get.snackbar(
                                            "Por favor llene el campo de nombre",
                                            controlua.mensajesUser,
                                            duration: Duration(seconds: 4),
                                          );
                                        } else if (user.text.isEmpty) {
                                          Get.snackbar(
                                            "Por favor llene el campo de correo",
                                            controlua.mensajesUser,
                                            duration: Duration(seconds: 4),
                                          );
                                        } else if (pass.text.isEmpty) {
                                          Get.snackbar(
                                            "Por favor llene el campo de contraseña",
                                            controlua.mensajesUser,
                                            duration: Duration(seconds: 4),
                                          );
                                        } else {
                                          controlua
                                              .crearUser(user.text, pass.text)
                                              .then((value) {
                                            if (controlua.estadoUser == null) {
                                              print('Error al registrar');
                                              Get.snackbar(
                                                "Esta cuenta ya existe",
                                                controlua.mensajesUser,
                                                duration: Duration(seconds: 2),
                                              );
                                            } else {
                                              if (controlua.mensajesUser ==
                                                  'Proceso exitoso') {
                                                Get.snackbar(
                                                  "¡Registrado Correctamente!",
                                                  controlua.mensajesUser,
                                                  duration:
                                                      Duration(seconds: 4),
                                                );
                                                Get.toNamed("/perfil",
                                                    arguments: [
                                                      nombre.text,
                                                      user.text,
                                                      pass.text
                                                    ]);
                                              }
                                            }
                                          });
                                        }
                                      } else {
                                        Get.snackbar(
                                            "No hay conexión a internet",
                                            "Por favor conectese a una red");
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
