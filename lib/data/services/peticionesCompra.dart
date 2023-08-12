import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class PeticionesCompra {
  static final SupabaseClient _client = Supabase.instance.client;

  static Future<dynamic> crearCompra(compra) async {
    try {
      print('compra: $compra');
      final tableNameCompra = 'compra';
      for (var i = 0; i < compra.length; i++) {
        final responseCompra =
            await _client.from(tableNameCompra).insert(compra[i]);
        print('responseCompra: $responseCompra');
      }
    } catch (error) {
      print('Error en la operación de creación de compra: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerCompras() async {
    List<Map<String, dynamic>> compras = [];
    try {
      final tableNameCompra = 'compra';
      final responseCompra = await _client.from(tableNameCompra).select('*');
      if (responseCompra.isNotEmpty) {
        compras = List<Map<String, dynamic>>.from(responseCompra);
        print("compras: $compras");
      } else {
        compras = [];
      }
      return compras;
    } catch (error) {
      print('Error en la operación de obtener compras: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> filtrarCompras(id) async {
    List<Map<String, dynamic>> compras = [];
    try {
      final tableNameCompra = 'compra';
      final responseCompra =
          await _client.from(tableNameCompra).select('*').eq('idpedido', id);
      if (responseCompra.isNotEmpty) {
        compras = List<Map<String, dynamic>>.from(responseCompra);
        print("compras: $compras");
      } else {
        compras = [];
      }
      return compras;
    } catch (error) {
      print('Error en la operación de obtener compras: $error');
      throw error;
    }
  }

  static Future<dynamic> eliminarCompra(idpedido) async {
    try {
      final tableNameCompra = 'compra';
      final responseCompra =
          await _client.from(tableNameCompra).delete().eq('idpedido', idpedido);
      return responseCompra;
    } catch (error) {
      print('Error en la operación de eliminar compra: $error');
      throw error;
    }
  }
}
