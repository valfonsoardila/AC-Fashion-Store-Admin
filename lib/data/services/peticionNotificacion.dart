import 'package:supabase_flutter/supabase_flutter.dart';

class PeticionesNotificacion {
  static final SupabaseClient _client = Supabase.instance.client;

  static Future<dynamic> crearNotificacion(
      Map<String, dynamic> notificacion) async {
    try {
      final tableName = 'notificacion';
      await _client.from(tableName).insert([notificacion]);
      return true;
    } catch (error) {
      print('Error en la operación de creación de notificacion: $error');
      throw error;
    }
  }

  static Future<dynamic> actualizarNotificacion(
      Map<String, dynamic> notificacion) async {
    try {
      final tableName = 'notificacion';
      print("esta es la notificacion: $notificacion");
      await _client
          .from(tableName)
          .update(notificacion)
          .eq('iduser', notificacion['iduser']);
      return true;
    } catch (error) {
      print('Error en la operación de creación de notificacion: $error');
      throw error;
    }
  }

  static Future<dynamic> eliminarNotificacion(
      Map<String, dynamic> notificacion) async {
    try {
      final tableName = 'notificacion';
      await _client.from(tableName).delete().eq('uid', notificacion['uid']);
      return true;
    } catch (error) {
      print('Error en la operación de creación de notificacion: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> filtrarNotificacion(
      String uid) async {
    try {
      List<Map<String, dynamic>> notificacions = [];
      final tableName = 'notificacion';
      final response = await _client.from(tableName).select('*').eq('uid', uid);
      print("esta es la respuesta: $response");
      if (response.isNotEmpty) {
        print("no esta vacio");
        notificacions = List<Map<String, dynamic>>.from(response);
      } else {
        notificacions = [];
      }
      return notificacions;
    } catch (error) {
      print('Error en la operación buscar notificacion: $error');
      throw error;
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerNotificaciones() async {
    try {
      List<Map<String, dynamic>> notificacions = [];
      final tableName = 'notificacion';
      final response = await _client.from(tableName).select('*');
      print("esta es la respuesta: $response");
      if (response.isNotEmpty) {
        print("no esta vacio");
        notificacions = List<Map<String, dynamic>>.from(response);
      } else {
        notificacions = [];
      }
      return notificacions;
    } catch (error) {
      print('Error en la operación buscar notificacion: $error');
      throw error;
    }
  }
}
