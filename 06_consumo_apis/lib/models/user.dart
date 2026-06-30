/// =============================================================================
/// CAPA DE MODELO (MODEL) - ARQUITECTURA MVVM
/// 
/// El Modelo representa la estructura de datos pura de la aplicación.
/// - No contiene lógica de presentación ni llamadas directas a APIs.
/// - Es responsable de la inicialización de los datos y de proveer constructores
///   o métodos para la serialización/deserialización de formatos como JSON.
/// =============================================================================
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

  /// Constructor de fábrica (factory): procesa lógica y retorna una nueva instancia.
  /// Es la forma estándar en Dart para mapear (deserializar) un Map de JSON a un objeto fuertemente tipado.
  /// 
  /// - Recibe un Map donde las claves son String y los valores son dynamic (pueden ser textos, números, sub-mapas).
  /// - El casteo explicito `as Type` ayuda a prevenir problemas de tipado dinámico en Flutter.
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

  /// Convierte el objeto fuertemente tipado a un mapa JSON estándar de Dart (serialización).
  /// 
  /// - Es de vital importancia para el almacenamiento local: codificamos esta estructura a String
  ///   para guardarla en SharedPreferences, y luego recrear la estructura 'company' -> 'name'
  ///   idéntica a como el servidor la entrega originalmente.
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
