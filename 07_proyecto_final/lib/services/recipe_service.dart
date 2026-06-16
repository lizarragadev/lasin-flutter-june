import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe.dart';

class RecipeService {
  // URL para obtener el listado de recetas de la API pública de pruebas DummyJSON
  static const String _url = 'https://dummyjson.com/recipes';

  // Realiza el llamado a la API, decodifica el cuerpo de la respuesta y devuelve una lista de recetas filtrada
  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        // La API devuelve un mapa JSON completo. Por ejemplo: { "recipes": [...], "total": 100, "skip": 0 }
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Obtenemos únicamente la clave "recipes" que es un listado de objetos JSON
        final List<dynamic> list = data['recipes'];
        
        // Mapea la lista de mapas dynamic a objetos fuertemente tipados
        return list.map((item) => Recipe.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar recetas: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de conexión al cargar recetas: $e');
    }
  }
}
