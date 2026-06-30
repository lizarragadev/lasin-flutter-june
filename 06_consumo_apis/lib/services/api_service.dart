// ignore_for_file: unused_import, unused_field
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

// endpoint

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));
      if(response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception("Error al obtener los usuarios: ${response.statusCode}");
      }
    } catch(e) {
      throw Exception(
          "Fallo en la conexión, asegúrate de tener acceso a internet");
    }
  }
}
