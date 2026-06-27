/// =============================================================================
/// CAPA DE MODELO (MODEL) - SKELETON
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

  // TODO: Crear el constructor de fábrica `fromJson` para deserializar el JSON recibido.
  // Pista: Recibe un Map<String, dynamic> json y mapea los campos correspondientes.
  // Recuerda acceder al nombre de la compañía desde el sub-mapa 'company' -> 'name'.
  // factory User.fromJson(Map<String, dynamic> json) { ... }

  // TODO: Crear el método `toJson` que retorne un Map<String, dynamic> para serialización local.
  // Map<String, dynamic> toJson() { ... }
}
