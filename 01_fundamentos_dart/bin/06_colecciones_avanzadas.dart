void main() {
  final List<String> lenguajes = ['Dart', 'Kotlin', 'Swift'];
  print('Lenguajes: $lenguajes');

  final Map<String, dynamic> config = {
    'tema': 'oscuro',
    'idioma': 'es',
    'esPremium': true,
  };
  print('Configuración: $config');

  final masLenguajes = ['JavaScript', 'Python'];
  final todosLosLenguajes = [...lenguajes, ...masLenguajes];
  print('Todos los lenguajes (Spread ...): $todosLosLenguajes');

  final bool mostrarBotonAdmin = true;
  final listaDeBotones = [
    'Boton Home',
    'Boton Perfil',
    if (mostrarBotonAdmin) 'Boton Panel Administrador',
    for (var lang in lenguajes) 'Boton de $lang',
  ];
  print('Botones generados condicionalmente: $listaDeBotones');

  final List<int> calificaciones = [10, 15, 8, 20, 11, 6];

  final aprobados = calificaciones.where((nota) => nota >= 11).toList();
  print('Notas aprobatorias (.where): $aprobados');

  final notasExplicadas = calificaciones.map((nota) {
    return 'Nota obtenida: $nota/20';
  }).toList();
  print('Notas formateadas (.map):\n$notasExplicadas');
}
