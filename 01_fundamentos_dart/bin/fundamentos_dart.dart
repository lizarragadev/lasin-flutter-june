// El punto de entrada principal para cualquier aplicación Dart. 'async' permite usar 'await' en su interior.
void main() async {
  print('=== EJERCICIO 1: Variables y Tipos de Datos ===');
  // Variables mutables con tipado explícito
  String nombre = 'Juan'; // Variable de tipo cadena de texto
  int edad = 25; // Variable de tipo número entero
  double estatura = 1.75; // Variable de tipo número decimal
  
  // Variables inmutables
  final String pais = 'Perú'; // Se asigna en tiempo de ejecución y no puede cambiar
  const double pi = 3.14159; // Se asigna en tiempo de compilación (constante pura)

  // Interpolación de variables dentro de un String usando '$'
  print('Nombre: $nombre, Edad: $edad, Estatura: $estatura');
  print('País: $pais, Pi: $pi');
  
  print('\n=== EJERCICIO 2: Null Safety ===');
  // El signo '?' indica que la variable puede almacenar un valor nulo
  String? nombreNulable;
  print('Valor nulable: $nombreNulable');
  
  // Operador '??' (coalescencia nula): si la variable es nula, asigna el valor de la derecha
  String nombreSeguro = nombreNulable ?? 'Invitado';
  print('Nombre seguro: $nombreSeguro');

  nombreNulable = 'Carlos';
  // Acceso seguro: no da error porque ya tiene asignado un valor
  print('Longitud: ${nombreNulable.length}');
  // Operador '!' (aserción de no nulo): le asegura a Dart que la variable no es nula bajo nuestro propio riesgo
  // ignore: unnecessary_non_null_assertion
  print('Llamada forzada: ${nombreNulable!}');

  print('\n=== EJERCICIO 3: Funciones ===');
  // Llamada a una función pasando argumentos posicionales
  String saludo = obtenerSaludo(nombre, edad);
  print(saludo);
  
  int numero = 5;
  // Llamada a una arrow function
  print('El doble de $numero es ${calcularDoble(numero)}');

  print('\n=== EJERCICIO 4: Clases y Objetos ===');
  // Instanciación de una clase usando constructores con argumentos nombrados
  Persona persona = Persona(nombre: 'Ana', edad: 22);
  persona.presentarse();

  print('\n=== EJERCICIO 5: Colecciones (Listas y Mapas) ===');
  // Lista de enteros
  List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // .where filtra elementos basándose en una condición lógica. .toList() convierte el iterable resultante de vuelta a lista
  List<int> pares = numeros.where((n) => n % 2 == 0).toList();
  print('Pares: $pares');

  // Mapa (estructura clave-valor) con tipo dinámico para los valores
  Map<String, dynamic> producto = {
    'nombre': 'Laptop Pro',
    'precio': 1200.99,
    'stock': 15
  };
  print('Producto: ${producto['nombre']} cuesta \$${producto['precio']}');

  print('\n=== EJERCICIO 6: Programación Asíncrona (Futures, async/await) ===');
  print('Solicitando datos del servidor...');
  // 'await' detiene la ejecución de esta línea hasta que el Future se resuelva
  String resultado = await obtenerDatosServidor();
  print('Resultado recibido: $resultado');
  print('Fin del programa principal.');
}

// Función clásica que recibe parámetros posicionales obligatorios y retorna un String
String obtenerSaludo(String nombre, int edad) {
  return 'Hola $nombre, tienes $edad años.';
}

// Función flecha (arrow function), ideal para funciones de una sola línea de código
int calcularDoble(int n) => n * 2;

// Definición de una clase orientada a objetos en Dart
class Persona {
  final String nombre; // Atributo inmutable
  final int edad; // Atributo inmutable

  // Constructor utilizando llaves '{}' para definir parámetros nombrados y obligatorios ('required')
  Persona({required this.nombre, required this.edad});

  // Método de la clase
  void presentarse() {
    print('Hola, mi nombre es $nombre y tengo $edad años.');
  }
}

// Función que simula una petición de red asíncrona retornando una promesa (Future)
Future<String> obtenerDatosServidor() async {
  // Simula un retardo asíncrono sin bloquear el hilo de ejecución principal de la aplicación
  await Future.delayed(const Duration(seconds: 2));
  return 'Datos cargados exitosamente de la nube';
}
