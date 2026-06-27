import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

/// =============================================================================
/// SERVICIO DE DATOS (SERVICE) - CAPA DE RED/DATOS DE MVVM
/// 
/// Esta clase gestiona el acceso a fuentes de datos externas (APIs REST).
/// - Su única responsabilidad es comunicarse con el backend y retornar datos limpios/tipados.
/// - No almacena estado (es stateless) ni gestiona variables de pantalla.
/// - Es consumida directamente por el ViewModel.
/// =============================================================================
class ApiService {
  // Dirección base del servicio REST API público (JSONPlaceholder)
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Método asíncrono que realiza una petición GET a la API REST.
  /// Retorna un Future que eventualmente contendrá la lista de objetos User.
  Future<List<User>> fetchUsers() async {
    try {
      // http.get solicita la información al endpoint. Uri.parse convierte el String de la URL a Uri.
      final response = await http.get(Uri.parse('$_baseUrl/users'));

      // El código HTTP 200 representa éxito en la petición (OK)
      if (response.statusCode == 200) {
        // jsonDecode convierte la cadena de texto plano (response.body) a List<dynamic> o Map<String, dynamic>
        final List<dynamic> data = jsonDecode(response.body);
        
        // Mapea cada mapa individual de la lista usando User.fromJson y luego convierte el iterable a List
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        // Si el código es distinto de 200 (ej: 404, 500), lanzamos una excepción con el código de error
        throw Exception('Error del servidor: Código ${response.statusCode}');
      }
    } catch (e) {
      // Captura fallas de conectividad (sin internet, timeout, DNS inválido) y las propaga hacia arriba
      throw Exception('Fallo en la conexión. Asegúrate de tener acceso a internet. ($e)');
    }
  }
}
