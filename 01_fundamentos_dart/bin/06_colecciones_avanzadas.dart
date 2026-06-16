/**
 * ============================================================================
 * LECCIÓN 6: COLECCIONES, OPERADORES AVANZADOS Y MANIPULACIÓN DE LISTAS
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * En las aplicaciones modernas, gran parte del trabajo consiste en recibir
 * colecciones de datos de un servidor, filtrarlas, transformarlas y finalmente
 * mostrarlas al usuario.
 * 
 * Dart cuenta con tres colecciones core:
 * - List: Secuencias ordenadas de elementos.
 * - Map: Estructuras asociativas clave-valor.
 * - Set: Colecciones de elementos únicos sin duplicados.
 * 
 * Además, Dart cuenta con operadores sintácticos exclusivos (como el Spread Operator,
 * Collection IF y Collection FOR) diseñados para declarar interfaces de usuario complejas
 * de forma limpia dentro del árbol de widgets de Flutter.
 */

void main() {
  print('=== TEORÍA Y EJEMPLOS: COLECCIONES Y OPERADORES ===');

  /**
   * 1. LISTAS (List)
   * 
   * Definición: Colección indexada de elementos ordenados.
   */
  final List<String> lenguajes = ['Dart', 'Kotlin', 'Swift'];
  print('Lenguajes indexados: $lenguajes');

  /**
   * 2. MAPAS (Map)
   * 
   * Definición: Colección de pares clave-valor. Las claves deben ser únicas.
   * En Flutter, los mapas JSON (Map<String, dynamic>) son el formato estándar de intercambio de datos.
   */
  final Map<String, dynamic> config = {
    'tema': 'oscuro',
    'idioma': 'es',
    'esPremium': true,
  };
  print('Configuración deserializada: $config');

  /**
   * 3. OPERADOR SPREAD '...' (Operador de Propagación)
   * 
   * Definición: Desempaqueta o expande los elementos de una colección dentro de otra.
   * 
   * ¿Por qué es vital en Flutter?:
   * Cuando construyes columnas o filas (Row/Column), su parámetro 'children' espera una lista
   * fija de widgets: List<Widget>. Si tienes una sublista de elementos generados dinámicamente,
   * puedes inyectarla en medio de otros widgets estáticos usando los tres puntos '...':
   * 
   * Column(
   *   children: [
   *     Text('Título Principal'), // Widget estático
   *     ...listaDeItemsDinamicos,  // Desempaqueta la lista de widgets usando spread
   *     Text('Pie de página')      // Widget estático
   *   ],
   * )
   */
  final masLenguajes = ['JavaScript', 'Python'];
  final todosLosLenguajes = [...lenguajes, ...masLenguajes];
  print('Todos los lenguajes (Spread ...): $todosLosLenguajes');

  /**
   * 4. COLLECTION 'IF' Y COLLECTION 'FOR'
   * 
   * Definición: Permiten usar estructuras de control condicionales o bucles iterativos
   * directamente en la declaración literaria de una lista.
   * 
   * ¿Por qué es vital en Flutter?:
   * Evita tener que separar la lógica de la UI en funciones externas pesadas. Puedes decidir
   * si dibujar un botón o iterar elementos directamente en el children del widget:
   * 
   * Column(
   *   children: [
   *     Text('Bienvenido'),
   *     if (usuario.isLogged) LogoutButton(), // Dibuja el botón de logout sólo si está logueado
   *     for (var amigo in listaAmigos) Avatar(amigo), // Dibuja una lista de avatares iterativamente
   *   ]
   * )
   */
  final bool mostrarBotonAdmin = true;
  final listaDeBotones = [
    'Boton Home',
    'Boton Perfil',
    if (mostrarBotonAdmin) 'Boton Panel Administrador', // Inserción condicional (Collection if)
    for (var lang in lenguajes) 'Boton de $lang', // Bucle inline (Collection for)
  ];
  print('Botones generados dinámicamente: $listaDeBotones');

  /**
   * 5. MÉTODOS DE TRANSFORMACIÓN: .WHERE() Y .MAP()
   * 
   * A) '.where': Evalúa cada elemento de la colección con una función lógica (predicado) y
   *    retorna únicamente los elementos que cumplan la condición. Equivale a un filtro.
   */
  final List<int> calificaciones = [10, 15, 8, 20, 11, 6];
  final aprobados = calificaciones.where((nota) => nota >= 11).toList(); // Convierte el iterable resultante a List
  print('Notas aprobatorias (.where): $aprobados');

  /**
   * B) '.map': Transforma cada elemento de la lista original aplicando una función y retorna
   *    una nueva colección con los resultados.
   * 
   * Aplicación Crítica en Flutter:
   * Es el mecanismo por excelencia para transformar tu lista de datos de negocio (modelos)
   * a componentes visuales (widgets) de Flutter:
   * 
   * List<Widget> cards = listadoProductos.map((prod) => CardProducto(producto: prod)).toList();
   */
  final notasExplicadas = calificaciones.map((nota) {
    return 'Nota obtenida: $nota/20';
  }).toList();
  print('Notas formateadas (.map):\n$notasExplicadas');
}
