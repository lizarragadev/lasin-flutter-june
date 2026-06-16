void main() async {
  print('=== EJERCICIO 1: Variables y Tipos de Datos ===');
  String nombre = 'Juan';
  int edad = 25;
  double estatura = 1.75;
  
  final String pais = 'Perú';
  const double pi = 3.14159;

  print('Nombre: $nombre, Edad: $edad, Estatura: $estatura');
  print('País: $pais, Pi: $pi');
  
  print('\n=== EJERCICIO 2: Null Safety ===');
  String? nombreNulable;
  print('Valor nulable: $nombreNulable');
  
  String nombreSeguro = nombreNulable ?? 'Invitado';
  print('Nombre seguro: $nombreSeguro');

  nombreNulable = 'Carlos';
  print('Longitud: ${nombreNulable.length}');
  // ignore: unnecessary_non_null_assertion
  print('Llamada forzada: ${nombreNulable!}');

  print('\n=== EJERCICIO 3: Funciones ===');
  String saludo = obtenerSaludo(nombre, edad);
  print(saludo);
  
  int numero = 5;
  print('El doble de $numero es ${calcularDoble(numero)}');

  print('\n=== EJERCICIO 4: Clases y Objetos ===');
  Persona persona = Persona(nombre: 'Ana', edad: 22);
  persona.presentarse();

  print('\n=== EJERCICIO 5: Colecciones (Listas y Mapas) ===');
  List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> pares = numeros.where((n) => n % 2 == 0).toList();
  print('Pares: $pares');

  Map<String, dynamic> producto = {
    'nombre': 'Laptop Pro',
    'precio': 1200.99,
    'stock': 15
  };
  print('Producto: ${producto['nombre']} cuesta \$${producto['precio']}');

  print('\n=== EJERCICIO 6: Programación Asíncrona (Futures, async/await) ===');
  print('Solicitando datos del servidor...');
  String resultado = await obtenerDatosServidor();
  print('Resultado recibido: $resultado');
  print('Fin del programa principal.');
}

String obtenerSaludo(String nombre, int edad) {
  return 'Hola $nombre, tienes $edad años.';
}

int calcularDoble(int n) => n * 2;

class Persona {
  final String nombre;
  final int edad;

  Persona({required this.nombre, required this.edad});

  void presentarse() {
    print('Hola, mi nombre es $nombre y tengo $edad años.');
  }
}

Future<String> obtenerDatosServidor() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Datos cargados exitosamente de la nube';
}
