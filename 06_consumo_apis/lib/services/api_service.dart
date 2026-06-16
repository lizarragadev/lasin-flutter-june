import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  // Dirección base del servicio REST API público
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Método asíncrono que retorna un Future que eventualmente contendrá la lista de objetos de tipo User
  Future<List<User>> fetchUsers() async {
    try {
      // http.get solicita la información al endpoint. Uri.parse convierte el String de la URL a un objeto Uri válido.
      final response = await http.get(Uri.parse('$_baseUrl/users'));

      // 200 representa éxito en la petición HTTP (Ok)
      if (response.statusCode == 200) {
        // jsonDecode convierte la cadena de texto plano del body en estructuras de datos de Dart (Listas y Mapas)
        final List<dynamic> data = jsonDecode(response.body);
        
        // Mapea cada mapa individual de la lista usando User.fromJson y luego convierte el iterable resultante a List
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        // Lanza un error si el servidor responde con un código de error (como 404 o 500)
        throw Exception('Error al cargar usuarios: Código ${response.statusCode}');
      }
    } catch (e) {
      // Captura fallos de conectividad (offline, timeout) y relanza la excepción para que la capture el FutureBuilder
      throw Exception('Fallo en la conexión: $e');
    }
  }
}
