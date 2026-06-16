/**
 * ============================================================================
 * LECCIÓN 1: VARIABLES, SISTEMA DE TIPOS E INMUTABILIDAD EN DART
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * Dart es un lenguaje con un sistema de tipos fuertemente tipado (strongly typed).
 * Esto significa que cada variable en Dart tiene un tipo estático que se conoce
 * en tiempo de compilación. El tipado estático ayuda a detectar errores comunes
 * antes de ejecutar la aplicación, lo cual es crítico en sistemas móviles (Android/iOS)
 * donde un error no capturado puede provocar que la app se cierre inesperadamente.
 * 
 * En esta lección aprenderemos sobre la asignación de variables, la inferencia
 * de tipos, la interpolación de texto y las herramientas de inmutabilidad
 * ('final' y 'const'), que son pilares arquitectónicos para el rendimiento en Flutter.
 */

void main() {
  print('=== TEORÍA Y EJEMPLOS: VARIABLES Y TIPADO ===');

  /**
   * 1. TIPADO EXPLÍCITO (Explicit Typing)
   * 
   * Definición: Ocurre cuando definimos explícitamente el tipo de dato que almacenará
   * la variable. Esto mejora la legibilidad para otros desarrolladores y asegura que el
   * compilador rechace cualquier asignación de un tipo incompatible.
   * 
   * Tipos de datos fundamentales:
   * - String: Cadenas de caracteres alfanuméricas.
   * - int: Números enteros (64-bit).
   * - double: Números de punto flotante de doble precisión (64-bit IEEE 754).
   * - bool: Valores de lógica booleana (verdadero o falso).
   */
  String curso = 'Flutter'; 
  int duracionHoras = 21; 
  double costo = 150.50; 
  bool esActivo = true; 
  print('¿El curso está activo?: $esActivo');

  /**
   * 2. INFERENCIA DE TIPOS (Type Inference)
   * 
   * Definición: Dart cuenta con un analizador estático capaz de deducir automáticamente
   * el tipo de una variable en función de su valor inicial. Para esto se usa la palabra
   * clave 'var'.
   * 
   * Regla de Oro: La inferencia NO convierte al lenguaje en dinámico. Una vez que 'var'
   * deduce que la variable es un String, se congela su tipo estático. Intentar asignarle
   * un entero o booleano más adelante causará un error de compilación.
   */
  var profesor = 'Camila'; // Dart infiere estáticamente que 'profesor' es de tipo String.
  // profesor = 25; // ERROR: A value of type 'int' can't be assigned to a variable of type 'String'.

  /**
   * 3. INTERPOLACIÓN DE STRINGS (String Interpolation)
   * 
   * Definición: Es el mecanismo que permite evaluar expresiones matemáticas o variables
   * directamente dentro de un String literario usando el símbolo '$'.
   * 
   * Ventaja teórica: Es mucho más eficiente que la concatenación tradicional con '+' (como
   * 'Hola ' + nombre), ya que Dart optimiza la creación de la cadena en memoria reduciendo
   * la fragmentación y la carga para el recolector de basura (Garbage Collector).
   * 
   * Sintaxis:
   * - $variable : Para variables simples.
   * - ${expresion} : Para evaluar propiedades o métodos (ej: ${objeto.propiedad} o \$$costo).
   */
  print('Bienvenido al curso de $curso de $duracionHoras horas.');
  print('Profesor/a: $profesor. Costo del curso: \$$costo');

  /**
   * 4. LA INMUTABILIDAD EN DART: 'final' VS 'const'
   * 
   * Teoría de Inmutabilidad: En la programación reactiva (que es la base de Flutter),
   * los datos inmutables son cruciales. Si los datos no pueden cambiar de forma
   * imprevista, el estado de la aplicación se vuelve predecible y fácil de rastrear.
   * Dart provee dos formas de inmutabilidad:
   * 
   * A) FINAL (Inmutabilidad en Tiempo de Ejecución / Runtime):
   * - Se inicializa una sola vez cuando la línea de código es ejecutada por el dispositivo.
   * - Permite asignar valores cuyo contenido real no conocemos al compilar la app
   *   (por ejemplo, la hora actual del sistema, datos de un API o coordenadas GPS).
   */
  final DateTime fechaInicio = DateTime.now(); // Se calcula al momento de correr la app.

  /**
   * B) CONST (Inmutabilidad en Tiempo de Compilación / Compile-Time):
   * - El valor debe ser absoluto, constante y conocido antes de que la aplicación corra.
   * - Representa constantes matemáticas o de configuración globales.
   * 
   * ¿Por qué es Vital para Flutter?:
   * Cuando marcas un widget con 'const' (ej: const Text('Hola')), Dart crea una única
   * instancia del widget en memoria y la reutiliza en todos lados (canonical instances).
   * Si la pantalla se redibuja (rebuild), Flutter ignora los widgets 'const', evitando
   * recrearlos y reduciendo drásticamente el uso de CPU y el parpadeo de pantalla.
   */
  const double pi = 3.14159; // Conocido en tiempo de compilación.
  const String version = '1.0.0';

  print('Fecha de inicio (final, dinámica): $fechaInicio');
  print('Valor de Pi (const, estática): $pi (versión: $version)');
}
