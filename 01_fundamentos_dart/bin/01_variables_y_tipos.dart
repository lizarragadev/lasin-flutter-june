// LECCIÓN 1: Variables, Tipado e Inmutabilidad en Dart

void main() {
  // 1. Tipado explícito (Recomendado cuando queremos ser claros sobre los datos)
  String curso = 'Flutter'; // Cadena de caracteres
  int duracionHoras = 21; // Números enteros
  double costo = 150.50; // Números decimales
  bool esActivo = true; // Valores booleanos (true/false)
  print('¿El curso está activo?: $esActivo');

  // 2. Inferencia de tipos con 'var'
  // Dart deduce automáticamente el tipo de dato al asignar el valor por primera vez.
  var profesor = 'Camila'; // Dart infiere que es String
  // profesor = 25; // ERROR: Una vez inferido, el tipo no puede cambiar (tipado estático)

  // 3. Interpolación de Strings (Uso de '$' y '${}')
  // Nos permite inyectar variables de forma legible dentro de cadenas de texto.
  print('Bienvenido al curso de $curso de $duracionHoras horas.');
  print('Profesor/a: $profesor. Costo del curso: \$$costo');

  // 4. Inmutabilidad: 'final' vs 'const'
  // En Flutter, la inmutabilidad es clave para el rendimiento de la UI.
  
  // 'final': Se define una sola vez en tiempo de ejecución (runtime).
  // Es útil para datos que vienen de bases de datos o peticiones HTTP.
  final DateTime fechaInicio = DateTime.now(); 

  // 'const': Se define en tiempo de compilación (compile-time). El valor debe ser constante y conocido antes de correr la app.
  // En Flutter, usarás 'const' para definir Widgets constantes (ej. const Text('Hola')).
  // Esto evita que Flutter redibuje de forma innecesaria ese widget, ahorrando memoria y batería.
  const double pi = 3.14159;
  const String version = '1.0.0';

  print('Fecha de inicio (final, dinámica): $fechaInicio');
  print('Valor de Pi (const, estática): $pi (versión: $version)');
}
