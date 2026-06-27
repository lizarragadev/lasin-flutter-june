class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String companyName;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.companyName,
  });

  // TODO: Crear el constructor de fábrica `fromJson` para deserializar el JSON recibido
  // factory User.fromJson(Map<String, dynamic> json) { ... }

  // TODO: Crear el método `toJson` que retorne un Map<String, dynamic>
  // Map<String, dynamic> toJson() { ... }
}
