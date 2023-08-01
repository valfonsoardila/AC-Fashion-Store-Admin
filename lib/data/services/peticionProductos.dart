import 'dart:async';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class PeticionesProducto {
  static final SupabaseClient _client = Supabase.instance.client;

  static Future<dynamic> crearProducto(
      Map<String, dynamic> producto, catalogo, modelo) async {
    try {
      var urlCatalogo = '';
      var urlModelo = '';
      if (catalogo != null) {
        urlCatalogo = await PeticionesProducto.cargarImagen(
            "Catalogo", catalogo, producto['categoria']);
        producto['catalogo'] = urlCatalogo.toString();
      }
      if (modelo != null) {
        urlModelo = await PeticionesProducto.cargarImagen(
            "Modelo", modelo, producto['categoria']);
        producto['modelo'] = urlModelo.toString();
      }
      print("este es el producto antes de guardar: $producto");
      await _client.from('producto').insert([producto]);
      return true;
    } catch (error) {
      print('Error en la operación de creación de catálogo: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerProductos() async {
    try {
      final folderPath =
          'producto'; // Carpeta donde estan almacenadas las fotos
      List<Map<String, dynamic>> productos = []; // Lista de productos
      var uids = await PeticionesProducto
          .obtenerListaUids(); // Lista de uids de los productos
      for (int i = 0; i < uids.length; i++) {
        Map<String, dynamic> producto = {}; // Lista de productos
        var uid = ""; // Uid del producto
        var response = null; // Respuesta de la peticion
        uid = uids[i]['id'].toString(); // Obtiene el uid del producto
        response = await _client.from(folderPath).select('*').eq('id', uid);
        producto = Map<String, dynamic>.from(response[0]);
        productos.add(producto);
      }
      return productos;
    } catch (e) {
      print("Error en la peticion:$e");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerListaUids() async {
    List<Map<String, dynamic>> uids = [];
    try {
      final response = await _client.from('producto').select('id');
      uids = List<Map<String, dynamic>>.from(response);
      return uids;
    } catch (e) {
      print("Error en la peticion:$e");
      return [];
    }
  }

  static Future<dynamic> filtrarproducto(id) async {
    print("este es el id del producto: $id");
    final instance = _client.storage; // Instancia de SupabaseStorage
    final tableName = 'producto'; // Carpeta donde deseas almacenar las fotos
    final folderName = 'producto';
    Map<String, dynamic> producto = {}; // Lista de productoes
    String fileName = '$id.png'; // Nombre del archivo
    try {
      //Intenta obtener el producto
      final response = await _client
          .from(tableName)
          .select('*')
          .eq('id', id); //Filtra el producto por id
      print("esta es la respuesta del filtro: $response");
      if (response != null) {
        // Si la respuesta no es nula
        var catalogo = ''; // Foto del producto
        var image = null; // Imagen del producto
        catalogo = response[0]['catalogo']
            .toString(); // Obtiene la catalogo del producto
        if (catalogo.isNotEmpty) {
          //Si la respuesta no es una url vacia
          image = await instance
              .from(folderName)
              .getPublicUrl(fileName); //Obtiene la url de la imagen
          response[0]['catalogo'] =
              image; //Agrega la url de la imagen al perfil
        }
      }
      producto = Map<String, dynamic>.from(response[0]);
      return producto; //Retorna el producto
    } catch (e) {
      print("Error en la peticion:$e");
      return {};
    }
  }

  static Future<dynamic> cargarImagen(
      var carpeta, var imagen, var categoria) async {
    final instance = _client.storage;
    var image = '';
    final bucketName = 'producto'; // Carpeta donde deseas almacenar las fotos
    var fileName = '$categoria/$carpeta/${imagen.path.split('/scaled_').last}';
    final file = File(imagen.path);
    try {
      final String path = await instance.from(bucketName).upload(
            fileName,
            file,
            fileOptions: FileOptions(cacheControl: '3600', upsert: false),
          );
      if (path != '') {
        image = await instance.from(bucketName).getPublicUrl(fileName);
      }
      final response = image;
      return response;
    } catch (e) {
      print('Error en la operación de carga de catalogo: $e');
    }
  }
}
