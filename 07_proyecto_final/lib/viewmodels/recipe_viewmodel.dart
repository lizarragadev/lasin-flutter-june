import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  final List<Recipe> _favorites = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters públicos
  List<Recipe> get recipes => _filteredRecipes;
  List<Recipe> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // TODO: Implementar el método cargarRecetas
  // 1. Establecer _isLoading = true y llamar a notifyListeners().
  // 2. Intentar llamar a _recipeService.fetchRecipes().
  // 3. Almacenar el resultado en _recipes y _filteredRecipes.
  // 4. Capturar errores y asignar un mensaje en _errorMessage.
  // 5. Finalizar estableciendo _isLoading = false y llamando a notifyListeners().
  Future<void> loadRecipes() async {
    // Código aquí
  }

  // TODO: Implementar el método filtrarRecetas por búsqueda de texto
  // Debe filtrar la lista _recipes comparando el nombre o ingredientes
  // con la query escrita y actualizar _filteredRecipes. Luego notificar.
  void filterRecipes(String query) {
    // Código aquí
  }

  // TODO: Implementar el método alternarFavorito (toggleFavorite)
  // Agrega o remueve una receta de la lista _favorites.
  // Verifica si ya existe por ID. Recuerda notificar cambios.
  void toggleFavorite(Recipe recipe) {
    // Código aquí
  }

  // TODO: Crear un método de utilidad isFavorite(Recipe recipe)
  // Retorna un bool indicando si la receta está en la lista de favoritos.
  bool isFavorite(Recipe recipe) {
    return false;
  }
}
