/// Modelo de datos que encapsula la información recopilada en el formulario.
/// 
/// TEORÍA SOBRE EL PASO DE ARGUMENTOS Y TRANSFERENCIA DE DATOS:
/// En lugar de pasar múltiples parámetros sueltos en el constructor de una pantalla
/// (lo cual es propenso a errores y poco escalable), la buena práctica en Flutter consiste
/// en agrupar la información relacionada en un objeto modelo (Data Transfer Object).
/// Este objeto inmutable es el que se enviará a través del sistema de rutas.
class RegistrationModel {
  // TEORÍA SOBRE PROPIEDADES FINAL:
  // Definimos los campos como [final] para garantizar la inmutabilidad de la estructura.
  // Una vez que el modelo es instanciado en memoria, sus datos no pueden ser alterados.
  final String name;
  final String email;
  final int age;
  final String ticketType;

  // TEORÍA SOBRE CONSTRUCTORES CONST:
  // - [const]: Permite crear instancias constantes en tiempo de compilación. Si Flutter
  //   detecta múltiples llamadas idénticas con los mismos parámetros constantes, reusará la misma
  //   dirección de memoria, mejorando enormemente el rendimiento y reduciendo la recolección de basura (GC).
  // - [required]: Modificador del sistema de tipos (Null Safety) que obliga a suministrar el parámetro
  //   al momento de construir el objeto, previniendo errores de puntero nulo en tiempo de ejecución.
  const RegistrationModel({
    required this.name,
    required this.email,
    required this.age,
    required this.ticketType,
  });
}
