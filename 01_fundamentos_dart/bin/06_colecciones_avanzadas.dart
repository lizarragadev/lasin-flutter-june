// LECCIÓN 6: Colecciones, Métodos de Filtrado y Operadores Avanzados

void main() {
  // 1. Listas (Estructuras de datos ordenadas)
  final List<String> lenguajes = ['Dart', 'Kotlin', 'Swift'];
  print('Lenguajes: $lenguajes');

  // 2. Mapas (Estructuras clave-valor)
  final Map<String, dynamic> config = {
    'tema': 'oscuro',
    'idioma': 'es',
    'esPremium': true,
  };
  print('Configuración: $config');

  // 3. Operador Spread '...' (Expansión de listas)
  // Permite insertar los elementos de una lista dentro de otra lista.
  // En Flutter se usa para inyectar listas de widgets dentro del children de un Row/Column.
  // Ejemplo: Column(children: [ const Header(), ...buildItems(), const Footer() ])
  final masLenguajes = ['JavaScript', 'Python'];
  final todosLosLenguajes = [...lenguajes, ...masLenguajes];
  print('Todos los lenguajes (Spread ...): $todosLosLenguajes');

  // 4. Collection 'if' y Collection 'for' (Estructuras de control dentro de colecciones)
  // Permiten renderizar elementos condicionalmente o en bucle directamente dentro del array de la lista.
  // En Flutter los usarás CONSTANTEMENTE en el children de tus Columnas o Filas.
  final bool mostrarBotonAdmin = true;
  final listaDeBotones = [
    'Boton Home',
    'Boton Perfil',
    if (mostrarBotonAdmin) 'Boton Panel Administrador', // Collection if
    for (var lang in lenguajes) 'Boton de $lang', // Collection for
  ];
  print('Botones generados condicionalmente: $listaDeBotones');

  // 5. Métodos de transformación en colecciones: .map() y .where()
  // Muy útiles en Flutter para transformar listas de modelos a listas de widgets.
  
  final List<int> calificaciones = [10, 15, 8, 20, 11, 6];

  // '.where' filtra elementos basándose en una condición lógica (retorna un iterable que convertimos a lista)
  final aprobados = calificaciones.where((nota) => nota >= 11).toList();
  print('Notas aprobatorias (.where): $aprobados');

  // '.map' transforma cada elemento de la lista a un tipo o formato diferente
  // En Flutter: convierte List<Product> a List<CardWidget>
  final notasExplicadas = calificaciones.map((nota) {
    return 'Nota obtenida: $nota/20';
  }).toList();
  print('Notas formateadas (.map):\n$notasExplicadas');
}
