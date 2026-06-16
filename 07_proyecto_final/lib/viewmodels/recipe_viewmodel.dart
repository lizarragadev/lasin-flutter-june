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

  List<Recipe> get recipes => _filteredRecipes;
  List<Recipe> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadRecipes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _recipes = await _recipeService.fetchRecipes();
      _filteredRecipes = List.from(_recipes);
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterRecipes(String query) {
    if (query.isEmpty) {
      _filteredRecipes = List.from(_recipes);
    } else {
      _filteredRecipes = _recipes.where((recipe) {
        final nameMatches = recipe.name.toLowerCase().contains(query.toLowerCase());
        final ingredientMatches = recipe.ingredients.any(
          (ing) => ing.toLowerCase().contains(query.toLowerCase()),
        );
        return nameMatches || ingredientMatches;
      }).toList();
    }
    notifyListeners();
  }

  void toggleFavorite(Recipe recipe) {
    final isFav = isFavorite(recipe);
    if (isFav) {
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners();
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }
}
