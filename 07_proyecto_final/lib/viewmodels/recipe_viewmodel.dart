import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

// El ViewModel representa la lógica de negocio y estado de la aplicación.
// Une la capa de datos (Service y Model) con la vista (UI).
// Extiende ChangeNotifier para permitir a los suscriptores (Views) reaccionar
// a los cambios de estado.
class RecipeViewModel extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  // Variables de estado privadas
  List<Recipe> _recipes = []; // Contiene todas las recetas obtenidas del servidor
  List<Recipe> _filteredRecipes = []; // Lista filtrada según las búsquedas del usuario
  final List<Recipe> _favorites = []; // Lista de recetas marcadas como favoritas
  bool _isLoading = false; // Estado de carga (útil para mostrar loaders)
  String? _errorMessage; // Mensaje de error (útil para mostrar alertas visuales)

  // Getters públicos para proteger el estado interno de la clase
  List<Recipe> get recipes => _filteredRecipes;
  List<Recipe> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Carga las recetas de la API
  Future<void> loadRecipes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notifica estado cargando a la UI para pintar el Spinner

    try {
      _recipes = await _recipeService.fetchRecipes();
      _filteredRecipes = List.from(_recipes); // Copia el listado completo inicialmente
    } catch (e) {
      // Guarda la descripción del error para que la UI la pinte
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners(); // Quita el loader y refresca la pantalla
    }
  }

  // Realiza búsquedas reactivas locales por nombre o ingredientes
  void filterRecipes(String query) {
    if (query.isEmpty) {
      _filteredRecipes = List.from(_recipes); // Vuelve a mostrar todo
    } else {
      _filteredRecipes = _recipes.where((recipe) {
        final nameMatches = recipe.name.toLowerCase().contains(query.toLowerCase());
        // Verifica si alguno de los ingredientes contiene el texto de búsqueda
        final ingredientMatches = recipe.ingredients.any(
          (ing) => ing.toLowerCase().contains(query.toLowerCase()),
        );
        return nameMatches || ingredientMatches;
      }).toList();
    }
    notifyListeners(); // Redibuja la lista filtrada reactivamente
  }

  // Agrega o remueve una receta de la lista de favoritos de forma segura
  void toggleFavorite(Recipe recipe) {
    final isFav = isFavorite(recipe);
    if (isFav) {
      // Remueve la receta comparando por ID
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners(); // Refresca los iconos y las vistas afectadas
  }

  // Método de conveniencia para verificar el estado de favoritos de una receta
  bool isFavorite(Recipe recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }
}
