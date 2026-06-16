class Recipe {
  final int id;
  final String name;
  final String image;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final String difficulty;
  final double rating;
  final String cuisine;

  const Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.rating,
    required this.cuisine,
  });

  // TODO: Implementar el constructor de fábrica `fromJson`
  // Pista: json['ingredients'] e json['instructions'] son List<dynamic>,
  // debes convertirlos a List<String> usando List<String>.from(...)
}
