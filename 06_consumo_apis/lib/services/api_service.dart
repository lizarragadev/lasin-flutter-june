// ignore_for_file: unused_import, unused_field
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

/// =============================================================================
/// SERVICIO DE DATOS (SERVICE) - SKELETON
/// 
/// Esta clase gestiona el acceso a fuentes de datos externas (APIs REST).
/// - Su única responsabilidad es comunicarse con el backend y retornar datos limpios/tipados.
/// - No almacena estado (es stateless) ni gestiona variables de pantalla.
/// =============================================================================
class ApiService {
  // Dirección base del servicio REST API público (JSONPlaceholder)
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // TODO: Implementar la petición GET a /users
  // 1. Hacer el llamado http.get() con la URL adecuada.
  // 2. Verificar si el status code es 200.
  // 3. Decodificar el body usando jsonDecode().
  // 4. Mapear la lista de mapas a una lista de objetos User (usando User.fromJson).
  // 5. Manejar errores con bloques try-catch o lanzando excepciones.
  Future<List<User>> fetchUsers() async {
    // Código aquí
    return [];
  }
}
