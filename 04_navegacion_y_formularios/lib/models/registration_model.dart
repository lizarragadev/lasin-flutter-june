/// Modelo de datos que encapsula la información recopilada en el formulario.
/// 
/// TEORÍA SOBRE EL PASO DE ARGUMENTOS:
/// En lugar de pasar múltiples parámetros sueltos en el constructor de una pantalla
/// (lo cual es propenso a errores y poco escalable), la buena práctica en Flutter consiste
/// en agrupar la información relacionada en un objeto modelo (Data Transfer Object).
/// Este objeto inmutable es el que se enviará a través del sistema de rutas.
class RegistrationModel {
  final String name;
  final String email;
  final int age;
  final String ticketType;

  const RegistrationModel({
    required this.name,
    required this.email,
    required this.age,
    required this.ticketType,
  });
}
