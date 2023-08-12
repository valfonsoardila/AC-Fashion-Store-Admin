import 'package:acfashion_store/data/services/peticionesCompra.dart';
import 'package:acfashion_store/data/services/peticionesPago.dart';
import 'package:acfashion_store/domain/controller/controllerUserAuth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class PeticionesPedido {
  static final ControlUserAuth controlua = Get.find();
  static final SupabaseClient _client = Supabase.instance.client;

  static Future<dynamic> crearPedido(pedido, carrito, perfil, total) async {
    try {
      var horaCompra = pedido['horaCompra'];
      final tableNamePedido = 'pedido';
      final responsePedido =
          await _client.from(tableNamePedido).insert([pedido]);
      var pedidoRegistrado = await _client
          .from(tableNamePedido)
          .select('*')
          .eq('horaCompra', horaCompra);
      var pago = {
        'idpedido': pedidoRegistrado[0]['uid'],
        'iduser': perfil['uid'],
        'nombre': perfil['nombre'],
        'pago': total,
      };
      carrito.forEach((element) {
        element['uid'] = pedidoRegistrado[0]['uid'];
      });
      print("CARRITO ANTES DE GUARDAR: $carrito");
      final responsePago = await PeticionesPago.crearPago([pago]);
      final responseCompra = await PeticionesCompra.crearCompra(carrito);
      print('responsePedido: $responsePedido');
      print('responsePago: $responsePago');
      print('responseCompra: $responseCompra');
      return responsePedido;
    } catch (error) {
      print('Error en la operación de creación de pedido: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerPedido() async {
    try {
      List<Map<String, dynamic>> pedidos = [];
      final tableName = 'pedido';
      final response = await _client.from(tableName).select('*');
      if (response.isNotEmpty) {
        pedidos = List<Map<String, dynamic>>.from(response);
        print("pedidos: $pedidos");
      } else {
        pedidos = [];
      }
      return pedidos;
    } catch (error) {
      print('Error en la operación de obtener pedido: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerPedidoEstado(
      String estado) async {
    try {
      List<Map<String, dynamic>> pedidos = [];
      final tableName = 'pedido';
      final response =
          await _client.from(tableName).select('*').eq('estadoEntrega', estado);
      if (response.isNotEmpty) {
        pedidos = List<Map<String, dynamic>>.from(response);
        print("pedidos: $pedidos");
      } else {
        pedidos = [];
      }
      return pedidos;
    } catch (error) {
      print('Error en la operación de obtener pedido: $error');
      throw error;
    }
  }

  static Future<dynamic> actualizarPedido(
      String id, Map<String, dynamic> pedido) async {
    try {
      final tableName = 'pedido';
      final response =
          await _client.from(tableName).update(pedido).eq('uid', id);
      return response;
    } catch (error) {
      print('Error en la operación de actualizar pedido: $error');
      throw error;
    }
  }

  static Future<dynamic> eliminarPedido(String id) async {
    try {
      final tableName = 'pedido';
      final response = await _client.from(tableName).delete().eq('uid', id);
      return response;
    } catch (error) {
      print('Error en la operación de eliminar pedido: $error');
      throw error;
    }
  }
}
