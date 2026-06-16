import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe.dart';

class RecipeService {
  static const String _url = 'https://dummyjson.com/recipes';

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> list = data['recipes'];
        return list.map((item) => Recipe.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar recetas: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de conexión al cargar recetas: $e');
    }
  }
}
