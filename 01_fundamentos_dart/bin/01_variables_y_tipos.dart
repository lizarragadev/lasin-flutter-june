void main() {
  String curso = 'Flutter';
  int duracionHoras = 21;
  double costo = 150.50;
  bool esActivo = true;
  print('¿El curso está activo?: $esActivo');

  var profesor = 'Camila';

  print('Bienvenido al curso de $curso de $duracionHoras horas.');
  print('Profesor/a: $profesor. Costo del curso: \$$costo');

  final DateTime fechaInicio = DateTime.now(); 
  const double pi = 3.14159;
  const String version = '1.0.0';

  print('Fecha de inicio (final, dinámica): $fechaInicio');
  print('Valor de Pi (const, estática): $pi (versión: $version)');
}
