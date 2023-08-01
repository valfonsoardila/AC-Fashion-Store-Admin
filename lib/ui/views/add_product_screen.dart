import 'dart:io';
import 'package:get/get.dart';
import 'package:acfashion_store/domain/controller/controllerProducto.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/styles/my_colors.dart';
import 'package:acfashion_store/ui/views/summary_views/see_products_screens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ControlProducto controlProducto = ControlProducto();
  TextEditingController _controllerCantidad = TextEditingController();
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerPrecio = TextEditingController();
  TextEditingController _controllerDescripcion = TextEditingController();
  TextEditingController _controllerColor = TextEditingController();
  TextEditingController _controllerTalla = TextEditingController();
  TextEditingController _controllerCategoria = TextEditingController();
  TextEditingController _controllerValoracion = TextEditingController();
  ImagePicker picker = ImagePicker();
  bool _isDarkMode = false;
  var _imageCatalogo;
  var _imageModelo;
  var modeImg;
  _galeria() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      print("Este es el modo de la imagen $modeImg");
      if (modeImg == 'catalogo') {
        _imageCatalogo = (image != null) ? File(image.path) : null;
      } else {
        _imageModelo = (image != null) ? File(image.path) : null;
      }
    });
  }

  _camara() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      print("Este es el modo de la imagen $modeImg");
      if (modeImg == 'catalogo') {
        _imageCatalogo = (image != null) ? File(image.path) : null;
      } else {
        _imageModelo = (image != null) ? File(image.path) : null;
      }
    });
  }

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Imagen de Galeria'),
                      onTap: () {
                        _galeria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Capturar Imagen'),
                    onTap: () {
                      _camara();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
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
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text('Agregar productos',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text('Imagen de catalogo',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Imagen de presentacion',
                                style: TextStyle(
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black)),
                            SizedBox(height: 10),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  modeImg = 'catalogo';
                                  _opcioncamara(
                                    context,
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                  width: 180,
                                  height: 200,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/box_products.png'),
                                    radius: 120,
                                    child: _imageCatalogo != null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                                FileImage(_imageCatalogo),
                                            radius: 120,
                                          )
                                        : CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.4),
                                            radius: 120,
                                            child: Center(
                                              child: IconButton(
                                                  alignment: Alignment.center,
                                                  onPressed: () {
                                                    modeImg = 'catalogo';
                                                    _opcioncamara(
                                                      context,
                                                    );
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                    Icons.add_a_photo,
                                                    size: 40,
                                                  ),
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text('Imagen de modelo',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Imagen sin fondo',
                                style: TextStyle(
                                    color: _isDarkMode
                                        ? Colors.white
                                        : Colors.black)),
                            SizedBox(height: 10),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  modeImg = 'modelo';
                                  _opcioncamara(
                                    context,
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                  width: 180,
                                  height: 200,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/box_products.png'),
                                    radius: 120,
                                    child: _imageModelo != null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                                FileImage(_imageModelo),
                                            radius: 120,
                                          )
                                        : CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.4),
                                            radius: 120,
                                            child: Center(
                                              child: IconButton(
                                                  alignment: Alignment.center,
                                                  onPressed: () {
                                                    modeImg = 'modelo';
                                                    _opcioncamara(
                                                      context,
                                                    );
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                    Icons.add_a_photo,
                                                    size: 40,
                                                  ),
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Cantidad de producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerCantidad,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          labelText: 'Existencias',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Nombre de producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextField(
                        controller: _controllerNombre,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          labelText: 'Nombre',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Precio de producto (COP)(Ej:10.000)',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerPrecio,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          labelText: 'Precio',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Descripción de producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _controllerDescripcion,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Descripción',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Color del producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _controllerColor,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Color',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Talla del producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _controllerTalla,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Talla',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Categoría del producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _controllerCategoria,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Categoría',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Valoración de 1.0 a 5.0',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerValoracion,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Valoración',
                          labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_imageCatalogo != null && _imageModelo != null) {
                      var nuevoProducto = {
                        'modelo':
                            _imageModelo != null ? _imageModelo.path : null,
                        'catalogo':
                            _imageCatalogo != null ? _imageCatalogo.path : null,
                        'cantidad': _controllerCantidad.text,
                        'nombre': _controllerNombre.text,
                        'precio': _controllerPrecio.text,
                        'descripcion': _controllerDescripcion.text,
                        'color': _controllerColor.text,
                        'talla': _controllerTalla.text,
                        'categoria': _controllerCategoria.text,
                        'valoracion': _controllerValoracion.text,
                      };
                      print("Este es el nuevo producto: $nuevoProducto");
                      controlProducto
                          .agregarproducto(
                              nuevoProducto, _imageCatalogo, _imageModelo)
                          .then((value) => {
                                if (controlProducto.mensajesProducto ==
                                    'Proceso exitoso')
                                  {
                                    Navigator.pop(context),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SeeProductsScreen()))
                                  }
                                else
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text(controlProducto
                                                .mensajesProducto),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Aceptar'))
                                            ],
                                          );
                                        })
                                  }
                              });
                    } else {
                      if (_imageCatalogo == null || _imageModelo == null) {
                        Get.snackbar("No ha seleccionado las imagenes",
                            "Por favor seleccione las imagenes de catalogo y modelo",
                            duration: Duration(seconds: 2));
                      } else {
                        if (_controllerCantidad.text == '' ||
                            _controllerNombre.text == '' ||
                            _controllerPrecio.text == '' ||
                            _controllerDescripcion.text == '' ||
                            _controllerColor.text == '' ||
                            _controllerTalla.text == '' ||
                            _controllerCategoria.text == '' ||
                            _controllerValoracion.text == '') {
                          Get.snackbar("No ha llenado todos los campos",
                              "Por favor llene todos los campos",
                              duration: Duration(seconds: 2));
                        }
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('Agregar producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.myPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
