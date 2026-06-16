/**
 * ============================================================================
 * LECCIÓN 4: PROGRAMACIÓN ORIENTADA A OBJETOS (POO) Y CONSTRUCTORES
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * Dart es un lenguaje orientado a objetos puro. Toda variable o dato es una
 * instancia de una clase, e incluso las funciones o números heredan de 'Object'.
 * 
 * En Flutter, la creación de interfaces de usuario se basa enteramente en instanciar
 * clases (Widgets). Comprender a fondo cómo inicializar objetos y usar los distintos
 * tipos de constructores de Dart es vital. Analizaremos:
 * - Constructor principal abreviado.
 * - Constructores Nombrados (para ofrecer distintas formas de instanciar un objeto).
 * - Constructores Factory (de fábrica, ideales para parsear JSON de APIs).
 * - Encapsulación mediante miembros privados, Getters y Setters.
 */

void main() {
  print('=== TEORÍA Y EJEMPLOS: CONSTRUCTORES Y POO ===');

  // 1. Instanciación estándar
  final usuario1 = Usuario(nombre: 'Carlos', edad: 30);
  print('Usuario 1: ${usuario1.nombre}, Edad: ${usuario1.edad}');

  /**
   * 2. CONSTRUCTORES NOMBRADOS (Named Constructors)
   * 
   * Definición: Dart no admite la sobrecarga tradicional de constructores (crear múltiples
   * constructores con el mismo nombre pero diferentes parámetros). En su lugar, Dart ofrece
   * Constructores Nombrados, permitiendo definir nombres claros para inicializaciones específicas.
   * 
   * Ejemplos en Flutter:
   * - EdgeInsets.all(16) : Crea margen uniforme en los 4 lados.
   * - EdgeInsets.symmetric(vertical: 8) : Crea margen simétrico.
   * - EdgeInsets.only(left: 10) : Crea margen en lados específicos.
   */
  final usuarioInvitado = Usuario.invitado(); // Instancia con datos predefinidos
  print('Invitado: ${usuarioInvitado.nombre}, Rol: ${usuarioInvitado.rol}');

  final usuarioAdmin = Usuario.administrador('Camila');
  print('Admin: ${usuarioAdmin.nombre}, Rol: ${usuarioAdmin.rol}');

  /**
   * 3. CONSTRUCTORES FACTORY (De fábrica)
   * 
   * Definición: Se declaran usando la palabra clave 'factory'. A diferencia de un constructor
   * generativo, un constructor factory no crea automáticamente una nueva instancia. Puede
   * buscar una instancia en cache, instanciar y retornar una subclase específica, o realizar
   * procesamiento de datos complejo antes de delegar a un constructor generativo.
   * 
   * Caso de uso estándar: Mapear un diccionario de tipo JSON (Map<String, dynamic>) a un modelo
   * de objeto fuertemente tipado en Dart.
   */
  final jsonRecibido = {'nombre': 'Lucía', 'edad': 24};
  final usuarioDesdeJson = Usuario.fromJson(jsonRecibido);
  print('Usuario desde JSON: ${usuarioDesdeJson.nombre}, Edad: ${usuarioDesdeJson.edad}');

  /**
   * 4. GETTERS Y SETTERS (Encapsulación)
   * 
   * Definición: En Dart, los miembros de clase (atributos o métodos) que inician con un
   * guion bajo '_' son privados. Pero la privacidad en Dart es a nivel de archivo (librería),
   * no a nivel de clase.
   * 
   * Para leer o escribir de forma segura variables privadas, se utilizan Getters y Setters.
   * Permiten añadir lógica intermedia de validación al asignar o formatear datos.
   */
  final cuenta = CuentaBancaria(100.0);
  cuenta.depositar = 50.0; // Invoca al setter de forma transparente como si fuera un atributo común
  print('Balance actual: \$${cuenta.balance}'); // Invoca al getter
}

class Usuario {
  final String nombre;
  final int edad;
  final String rol;

  // Constructor Principal con sintaxis simplificada (Generative Shorthand Constructor)
  // Inicializa los atributos directamente sin necesidad de escribir un cuerpo '{}' redundante.
  Usuario({
    required this.nombre,
    required this.edad,
    this.rol = 'Estudiante',
  });

  // Constructor Nombrado 1: 'invitado'
  // Usa la sintaxis ':' para definir una lista de inicializadores que se ejecuta
  // antes de que el objeto sea creado. No tiene cuerpo '{}'.
  Usuario.invitado()
      : nombre = 'Invitado de Prueba',
        edad = 18,
        rol = 'Invitado';

  // Constructor Nombrado 2: 'administrador'
  Usuario.administrador(String nombreAdmin)
      : nombre = nombreAdmin,
        edad = 35,
        rol = 'Administrador';

  // Constructor Factory
  // Mapea un JSON a un objeto de la clase Usuario.
  // Nota que debe retornar explícitamente un objeto mediante la palabra clave 'return'.
  factory Usuario.fromJson(Map<String, dynamic> json) {
    // Conversiones y protecciones contra nulos
    final nombreMapeado = json['nombre'] as String? ?? 'Sin Nombre';
    final edadMapeada = json['edad'] as int? ?? 0;
    
    // Retorna una nueva instancia de la clase llamando al constructor principal
    return Usuario(
      nombre: nombreMapeado,
      edad: edadMapeada,
      rol: 'Estudiante',
    );
  }
}

class CuentaBancaria {
  double _saldo; // Atributo privado al archivo (inicia con '_')

  CuentaBancaria(this._saldo);

  // Getter: Permite exponer el balance al exterior de forma de "sólo lectura"
  double get balance => _saldo;

  // Setter: Permite controlar cómo se modifica el saldo, impidiendo montos incorrectos
  set depositar(double monto) {
    if (monto > 0) {
      _saldo += monto;
    } else {
      print('El monto a depositar debe ser positivo.');
    }
  }
}
