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

  // Constructor de fábrica encargado de mapear la estructura de mapa JSON a un objeto Recipe.
  // Nota la conversión de tipos dinámicos provenientes del JSON a colecciones fuertemente tipadas en Dart.
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      // Convierte una lista dinámica de JSON (List<dynamic>) a una lista de cadenas de texto estáticas (List<String>)
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      prepTimeMinutes: json['prepTimeMinutes'] as int,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      difficulty: json['difficulty'] as String,
      // Convierte el valor numérico a double de forma segura (por si viene un entero o decimal)
      rating: (json['rating'] as num).toDouble(),
      cuisine: json['cuisine'] as String,
    );
  }

  // Serializador inverso para mapear el objeto fuertemente tipado a una estructura clave-valor dinámica
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'difficulty': difficulty,
      'rating': rating,
      'cuisine': cuisine,
    };
  }
}
