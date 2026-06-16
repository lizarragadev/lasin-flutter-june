// LECCIÓN 3: Funciones, Parámetros y Callbacks en Dart

void main() {
  // 1. Llamada a una función con parámetros posicionales
  saludarPosicional('Juan', 25);

  // 2. Llamada a una función con parámetros nombrados
  // En Flutter, casi todos los widgets usan parámetros nombrados para ser descriptivos.
  // Ejemplo: Text('Texto', style: TextStyle(...))
  saludarNombrado(
    nombre: 'Ana',
    edad: 28,
    esPremium: true, // Parámetro opcional
  );

  // 3. Arrow Functions (Funciones Flecha)
  // Útiles para escribir funciones rápidas de una sola línea.
  print('El doble de 10 es ${calcularDoble(10)}');

  // 4. Funciones Anónimas y Callbacks (Cruciales para eventos en Flutter)
  // Una función sin nombre que se pasa como argumento a otra función.
  // En Flutter, lo verás constantemente en los eventos de los botones:
  // ElevatedButton(onPressed: () { ... }, child: Text('Click'))
  
  ejecutarOperacion(5, 4, (resultado) {
    print('Callback ejecutado. El resultado de la operación es: $resultado');
  });

  // Sintaxis simplificada de callback con arrow function
  ejecutarOperacion(10, 10, (res) => print('Multiplicación rápida: $res'));
}

// 1. Parámetros Posicionales (Obligatorios y deben respetar el orden al llamarse)
void saludarPosicional(String nombre, int edad) {
  print('Hola $nombre, tienes $edad años.');
}

// 2. Parámetros Nombrados (Encerrados entre llaves `{}`)
// Se llaman especificando el nombre del argumento.
// 'required': Indica que el parámetro no puede omitirse.
// Parámetros sin 'required' pueden tener un valor asignado por defecto (como esPremium).
void saludarNombrado({
  required String nombre,
  required int edad,
  bool esPremium = false, // Valor por defecto
}) {
  print('Usuario: $nombre | Edad: $edad | Suscripción Premium: $esPremium');
}

// 3. Función Flecha (Arrow Function)
int calcularDoble(int numero) => numero * 2;

// 4. Función de orden superior que recibe una función como parámetro (Callback)
// 'operacion' es un callback que recibe un entero y no retorna nada (void).
void ejecutarOperacion(int a, int b, void Function(int) operacion) {
  final suma = a + b;
  operacion(suma); // Invoca el callback enviando el resultado
}
