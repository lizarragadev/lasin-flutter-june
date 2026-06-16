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

  // Constructor de fábrica (factory): permite procesar lógica y retornar una nueva instancia de la clase.
  // Es la forma estándar en Dart para mapear (deserializar) un Map de JSON a un objeto fuertemente tipado.
  // Recibe un Map donde las claves son String y los valores son dynamic (pueden ser textos, números, sub-mapas).
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int, // Fuerza el casteo a número entero
      name: json['name'] as String, // Fuerza el casteo a String
      username: json['username'] as String,
      email: json['email'] as String,
      // Accede a un objeto anidado: 'company' es un sub-mapa dentro del JSON,
      // del cual extraemos el campo 'name'.
      companyName: json['company']['name'] as String,
    );
  }

  // Método que convierte el objeto fuertemente tipado de vuelta a un mapa JSON (serialización).
  // Es útil para enviar información en peticiones POST/PUT al servidor.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'company': {
        'name': companyName,
      },
    };
  }
}
