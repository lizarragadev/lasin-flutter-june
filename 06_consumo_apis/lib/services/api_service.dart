// ignore_for_file: unused_import, unused_field
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // TODO: Implementar la petición GET a /users
  // 1. Hacer el llamado http.get() con la URL adecuada.
  // 2. Verificar si el status code es 200.
  // 3. Decodificar el body usando jsonDecode().
  // 4. Mapear la lista de mapas a una lista de objetos User (usando User.fromJson).
  // 5. Manejar errores con bloques try-catch o lanzando excepciones.
  Future<List<User>> fetchUsers() async {
    return [];
  }
}
