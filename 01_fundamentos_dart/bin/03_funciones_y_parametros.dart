/**
 * ============================================================================
 * LECCIÓN 3: FUNCIONES, PARÁMETROS Y PROGRAMACIÓN FUNCIONAL (CALLBACKS)
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * En Dart, las funciones son objetos de primera clase (first-class citizens).
 * Esto significa que una función es un tipo de dato en sí mismo (de clase 'Function'),
 * lo que permite asignarla a variables, pasarla como parámetro a otras funciones
 * o retornarla.
 * 
 * La flexibilidad en los parámetros de Dart es una de las razones por las cuales
 * Flutter es tan expresivo. Veremos dos tipos de parámetros principales:
 * - Posicionales: Importa el orden y la posición en la llamada.
 * - Nombrados: Se especifican usando su nombre, lo cual elimina ambigüedades
 *   en componentes de interfaz de usuario con múltiples propiedades.
 */

void main() {
  print('=== TEORÍA Y EJEMPLOS: FUNCIONES Y CALLBACKS ===');

  /**
   * 1. PARÁMETROS POSICIONALES
   * 
   * Definición: Los argumentos se asocian a las variables de la función según el orden
   * en que se declaran. Es el estándar en la mayoría de lenguajes.
   */
  saludarPosicional('Juan', 25);

  /**
   * 2. PARÁMETROS NOMBRADOS (Named Parameters)
   * 
   * Definición: Se definen encerrando los parámetros entre llaves '{}'. Al invocar la función,
   * debes escribir explícitamente el nombre del parámetro seguido de dos puntos y el valor.
   * 
   * Ventaja en Flutter: Imagina un widget 'Container' que tiene color, margen, bordes,
   * alineación, ancho, alto e hijos. Si los parámetros fueran posicionales, tendrías que
   * recordar la posición exacta de cada uno. Con los parámetros nombrados, escribes:
   * Container(width: 100, height: 50, color: Colors.blue) de forma clara y sin importar el orden.
   * 
   * Modificadores de Parámetros Nombrados:
   * - 'required': Obliga al invocador a pasar el argumento para evitar que sea nulo.
   * - Parámetros opcionales: Si no llevan 'required', deben tener un valor por defecto.
   */
  saludarNombrado(
    nombre: 'Ana',
    edad: 28,
    esPremium: true, // Parámetro opcional que anula el valor por defecto
  );

  /**
   * 3. FUNCIONES FLECHA (Arrow Functions)
   * 
   * Definición: Es una sintaxis abreviada usando el operador '=>' (fat arrow).
   * Equivale a un bloque de código '{ return expresion; }'. Se usa únicamente
   * para funciones que constan de una sola línea de código.
   */
  print('El doble de 10 es ${calcularDoble(10)}');

  /**
   * 4. FUNCIONES ANÓNIMAS Y CALLBACKS (High-Order Functions)
   * 
   * Definición de Callback: Es una función que pasamos como argumento a otra función,
   * con la expectativa de que sea ejecutada ("llamada de vuelta") cuando ocurra un evento
   * o termine una operación.
   * 
   * Aplicación Práctica en Flutter:
   * Cada vez que creas un botón en Flutter, tienes que indicarle qué código ejecutar cuando
   * el usuario lo presione. Para eso pasas una función anónima (sin nombre) al parámetro
   * nombrado 'onPressed':
   * 
   * ElevatedButton(
   *   onPressed: () {
   *     print('¡Botón presionado!');
   *   },
   *   child: Text('Guardar'),
   * )
   */
  // Pasamos una función anónima clásica como callback
  ejecutarOperacion(5, 4, (resultado) {
    print('Callback ejecutado. El resultado de la operación es: $resultado');
  });

  // Pasamos una función anónima resumida usando sintaxis flecha como callback
  ejecutarOperacion(10, 10, (res) => print('Multiplicación rápida en callback: $res'));
}

// 1. Definición con Parámetros Posicionales Obligatorios
void saludarPosicional(String nombre, int edad) {
  print('Hola $nombre, tienes $edad años.');
}

// 2. Definición con Parámetros Nombrados
// Nota cómo usamos 'required' para los valores obligatorios y '=' para asignar valores por defecto a los opcionales.
void saludarNombrado({
  required String nombre,
  required int edad,
  bool esPremium = false, // Parámetro opcional con valor por defecto
}) {
  print('Usuario: $nombre | Edad: $edad | Suscripción Premium: $esPremium');
}

// 3. Arrow Function (Sintaxis concisa para expresiones unitarias)
int calcularDoble(int numero) => numero * 2;

// 4. Función de orden superior (recibe otra función 'operacion' como parámetro)
// El tipo de dato del parámetro es 'void Function(int)', que describe a cualquier
// función que reciba un entero como parámetro y no retorne ningún valor (void).
void ejecutarOperacion(int a, int b, void Function(int) operacion) {
  final suma = a + b;
  operacion(suma); // Ejecuta la función que se le pasó como argumento
}
