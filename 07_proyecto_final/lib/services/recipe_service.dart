import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe.dart';

class RecipeService {
  static const String _url = 'https://dummyjson.com/recipes';

  // TODO: Implementar la petición GET a la API de recetas
  // Debe hacer la petición, decodificar el JSON y retornar un List<Recipe>.
  // Recuerda que la respuesta de dummyjson devuelve un objeto que contiene la clave "recipes".
  Future<List<Recipe>> fetchRecipes() async {
    // Código aquí
    return [];
  }
}
