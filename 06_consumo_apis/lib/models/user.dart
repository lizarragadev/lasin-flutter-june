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
  // Pista: Recibe un Map<String, dynamic> json y mapea los campos correspondientes.
  // Recuerda acceder al nombre de la compañía desde el sub-mapa 'company' -> 'name'.
  
  // TODO: Crear el método `toJson` que retorne un Map<String, dynamic>
}
