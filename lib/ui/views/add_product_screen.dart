import 'dart:io';
import 'dart:math';
import 'package:acfashion_store/ui/models/product_model.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:get/get.dart';
import 'package:acfashion_store/domain/controller/controllerProducto.dart';
import 'package:acfashion_store/ui/models/theme_model.dart';
import 'package:acfashion_store/ui/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  final producto;
  final productoActual;
  final productosAgregados;
  AddProductScreen(
      {super.key, this.producto, this.productoActual, this.productosAgregados});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ControlProducto controlProducto = ControlProducto();
  TextEditingController _controllerUid = TextEditingController();
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
  Map<String, dynamic> _producto = {};
  List<Map<String, dynamic>> _nuevosProductos = [];
  List<ProductModel> _productosConvertido = [];
  bool _isEdit = false;
  var _imageCatalogo;
  var _imageModelo;
  var modeImg;
  String tallaSeleccionada =
      'M'; // Variable de estado para almacenar el valor seleccionado de la valoración
  var tallas = <String>['Unica', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String valoracionSeleccionada =
      '4.0'; // Variable de estado para almacenar el valor seleccionado de la valoración
  var valoraciones = <String>['5.0', '4.0', '3.0', '2.0', '1.0'];
  String categoriaSeleccionada =
      'Caballeros'; // Variable de estado para almacenar el valor seleccionado de la categoria
  var categorias = <String>[
    'Damas',
    'Caballeros',
    'Niños',
    'Niñas',
  ];

  MoneyMaskedTextController _moneyController = MoneyMaskedTextController(
    decimalSeparator: ',', // Separador decimal
    thousandSeparator: '.', // Separador de miles
    initialValue: 0, // Valor inicial (puedes cambiarlo según tus necesidades)
  );
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

  void validarEdicion() {
    if (_producto.isNotEmpty) {
      _isEdit = true;
    } else {
      _isEdit = false;
    }
  }

  void retornarProducto(String opcion, Map<String, dynamic> producto) {
    print("Esta es la opcion $opcion");
    if (producto != {}) {
      widget.productoActual(opcion, producto);
    }
  }

  void retornarProductosAgregados(List<ProductModel> productos) {
    print("Esta es la opcion $productos");
    if (productos != []) {
      widget.productosAgregados(productos);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.producto != null) {
      _producto = widget.producto;
      _controllerUid.text = _producto['id'];
      _controllerCantidad.text = _producto['cantidad'].toString();
      _controllerNombre.text = _producto['nombre'];
      _moneyController.text = "${_producto['precio']},00";
      _controllerDescripcion.text = _producto['descripcion'];
      _controllerColor.text = _producto['color'];
      _controllerTalla.text = _producto['talla'];
      _controllerCategoria.text = _producto['categoria'];
      _controllerValoracion.text = _producto['valoracion'].toString();
      _imageCatalogo = _producto['imageCatalogo'];
      _imageModelo = _producto['imageModelo'];
    }
    validarEdicion();
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
      appBar: _isEdit != false
          ? AppBar(
              backgroundColor: _isDarkMode ? Colors.black : Colors.white,
              elevation: 0,
              title: Text(
                'Gestionar producto',
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
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
            )
          : AppBar(
              backgroundColor: _isDarkMode
                  ? const Color.fromARGB(255, 28, 27, 27)
                  : const Color.fromARGB(255, 245, 243, 243),
              leading: Container(),
              flexibleSpace: Center(
                child: Text('Agregar productos',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black)),
              ),
            ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
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
                            Text('Imagen de catálogo',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Imagen de presentación',
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
                                    child: _isEdit != false
                                        ? CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.shade700,
                                            backgroundImage: NetworkImage(
                                                _producto['imageCatalogo']),
                                            radius: 120,
                                          )
                                        : _imageCatalogo != null
                                            ? CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                backgroundImage:
                                                    FileImage(_imageCatalogo),
                                                radius: 120,
                                              )
                                            : CircleAvatar(
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.4),
                                                radius: 120,
                                                child: Center(
                                                  child: IconButton(
                                                      alignment:
                                                          Alignment.center,
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
                                      child: _isEdit != false
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade700,
                                              backgroundImage: NetworkImage(
                                                  _producto['imageModelo']),
                                              radius: 120,
                                            )
                                          : _imageModelo != null
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage:
                                                      FileImage(_imageModelo),
                                                  radius: 120,
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.4),
                                                  radius: 120,
                                                  child: Center(
                                                    child: IconButton(
                                                        alignment:
                                                            Alignment.center,
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
                                                )),
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
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: _isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 254, 12, 131),
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
                          prefixIcon: Icon(
                            Icons.local_offer,
                            color: _isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 254, 12, 131),
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
                        'Precio de producto (COP)',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _moneyController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 254, 12, 131)),
                          ),
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: _isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 254, 12, 131),
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
                          prefixIcon: Icon(
                            Icons.description,
                            color: _isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 254, 12, 131),
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
                          prefixIcon: Icon(
                            Icons.color_lens,
                            color: _isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 254, 12, 131),
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                              .shade500, // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Puedes ajustar la esquina redondeada aquí
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.straighten, // Puedes cambiar el icono aquí
                              color: _isDarkMode != false
                                  ? Colors.white
                                  : Color.fromARGB(255, 254, 12, 131),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              hint: Text(
                                'Talla',
                                style: TextStyle(
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              dropdownColor: _isDarkMode != false
                                  ? Colors.grey[800]
                                  : Colors.white,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: _isDarkMode != false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: _isDarkMode != false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              value: tallaSeleccionada,
                              onChanged: (newValue) {
                                setState(() {
                                  tallaSeleccionada = newValue
                                      .toString(); // Actualiza el valor seleccionado
                                });
                              },
                              items: tallas.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    )
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                              .shade500, // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Puedes ajustar la esquina redondeada aquí
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.category, // Puedes cambiar el icono aquí
                              color: _isDarkMode != false
                                  ? Colors.white
                                  : Color.fromARGB(255, 254, 12, 131),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              hint: Text(
                                'Categoria',
                                style: TextStyle(
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              dropdownColor: _isDarkMode != false
                                  ? Colors.grey[800]
                                  : Colors.white,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: _isDarkMode != false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: _isDarkMode != false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              value: categoriaSeleccionada,
                              onChanged: (newValue) {
                                setState(() {
                                  categoriaSeleccionada = newValue
                                      .toString(); // Actualiza el valor seleccionado
                                });
                              },
                              items: categorias.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    )
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                              .shade500, // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Puedes ajustar la esquina redondeada aquí
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.star, // Puedes cambiar el icono aquí
                              color: _isDarkMode != false
                                  ? Colors.white
                                  : Color.fromARGB(255, 254, 12, 131),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              hint: Text(
                                'Valoracion',
                                style: TextStyle(
                                  color: _isDarkMode != false
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              dropdownColor: _isDarkMode != false
                                  ? Colors.grey[800]
                                  : Colors.white,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: _isDarkMode != false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              iconSize: 36,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: _isDarkMode != false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              value: valoracionSeleccionada,
                              onChanged: (newValue) {
                                setState(() {
                                  valoracionSeleccionada = newValue
                                      .toString(); // Actualiza el valor seleccionado
                                });
                              },
                              items: valoraciones.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                _isEdit != false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _controllerPrecio.text =
                                  _moneyController.text.replaceAll(',00', '');
                              print('Editar');
                              FocusScope.of(context).unfocus();
                              if (_imageCatalogo != '' && _imageModelo != '') {
                                var nuevoProducto = {
                                  'id': _controllerUid.text,
                                  'modelo': _imageModelo.runtimeType != String
                                      ? _imageModelo.path
                                      : _imageModelo,
                                  'catalogo':
                                      _imageCatalogo.runtimeType != String
                                          ? _imageCatalogo.path
                                          : _imageCatalogo,
                                  'cantidad': _controllerCantidad.text,
                                  'nombre': _controllerNombre.text,
                                  'precio': _controllerPrecio.text,
                                  'descripcion': _controllerDescripcion.text,
                                  'color': _controllerColor.text,
                                  'talla': _controllerTalla.text,
                                  'categoria': _controllerCategoria.text,
                                  'valoracion': _controllerValoracion.text,
                                };
                                print(nuevoProducto);
                                controlProducto
                                    .actualizarproducto(
                                  nuevoProducto,
                                  _imageCatalogo,
                                  _imageModelo,
                                )
                                    .then((value) {
                                  if (controlProducto.mensajesProducto ==
                                      'Proceso exitoso') {
                                    retornarProducto("editar", nuevoProducto);
                                    Navigator.of(context).pop();
                                  }
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text('Editar',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.myPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _controllerPrecio.text =
                                  _moneyController.text.replaceAll(',00', '');
                              print('Eliminar');
                              FocusScope.of(context).unfocus();
                              var nuevoProducto = {
                                'id': _controllerUid.text,
                                'modelo': _imageModelo.runtimeType != String
                                    ? _imageModelo.path
                                    : _imageModelo,
                                'catalogo': _imageCatalogo.runtimeType != String
                                    ? _imageCatalogo.path
                                    : _imageCatalogo,
                                'cantidad': _controllerCantidad.text,
                                'nombre': _controllerNombre.text,
                                'precio': _controllerPrecio.text,
                                'descripcion': _controllerDescripcion.text,
                                'color': _controllerColor.text,
                                'talla': _controllerTalla.text,
                                'categoria': _controllerCategoria.text,
                                'valoracion': _controllerValoracion.text,
                              };
                              controlProducto
                                  .eliminarproducto(nuevoProducto)
                                  .then((value) {
                                if (controlProducto.mensajesProducto ==
                                    'Proceso exitoso') {
                                  retornarProducto("eliminar", nuevoProducto);
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text('Eliminar',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.myPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _controllerPrecio.text =
                              _moneyController.text.replaceAll(',00', '');
                          String cantidadText = _controllerCantidad.text;
                          int cantidadEntero = int.tryParse(cantidadText) ?? 0;
                          FocusScope.of(context).unfocus();
                          print('Agregar');
                          if (_imageCatalogo != null && _imageModelo != null) {
                            var nuevoProducto = {
                              'modelo': _imageModelo != null
                                  ? _imageModelo.path
                                  : null,
                              'catalogo': _imageCatalogo != null
                                  ? _imageCatalogo.path
                                  : null,
                              'cantidad': cantidadEntero,
                              'nombre': _controllerNombre.text,
                              'precio': _controllerPrecio.text,
                              'descripcion': _controllerDescripcion.text,
                              'color': _controllerColor.text,
                              'talla': tallaSeleccionada,
                              'categoria': categoriaSeleccionada,
                              'valoracion': valoracionSeleccionada,
                            };
                            print("Este es el nuevo producto: $nuevoProducto");
                            controlProducto
                                .agregarproducto(
                                    nuevoProducto, _imageCatalogo, _imageModelo)
                                .then((value) => {
                                      if (controlProducto.mensajesProducto ==
                                          'Proceso exitoso')
                                        {
                                          controlProducto
                                              .obtenerproductos()
                                              .then((value) => {
                                                    if (controlProducto
                                                            .mensajesProducto ==
                                                        'Proceso exitoso')
                                                      {
                                                        _nuevosProductos =
                                                            controlProducto
                                                                .datosProductos,
                                                        for (int i = 0;
                                                            i <
                                                                _nuevosProductos
                                                                    .length;
                                                            i++)
                                                          {
                                                            _productosConvertido[
                                                                    i] =
                                                                ProductModel
                                                                    .fromJson(
                                                                        _nuevosProductos[
                                                                            i]),
                                                          },
                                                        retornarProductosAgregados(
                                                            _productosConvertido),
                                                        Get.snackbar(
                                                            "Producto agregado correctamente✅",
                                                            "Por favor vuelva al inicio",
                                                            duration: Duration(
                                                                seconds: 2))
                                                      }
                                                  }),
                                        }
                                      else
                                        {
                                          Get.snackbar(
                                              "Error al agregar el producto❌",
                                              "Por favor vuelva a intentarlo",
                                              duration: Duration(seconds: 2))
                                        }
                                    });
                          } else {
                            if (_imageCatalogo == null ||
                                _imageModelo == null) {
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
