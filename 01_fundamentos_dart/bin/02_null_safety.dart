/**
 * ============================================================================
 * LECCIÓN 2: SOUND NULL SAFETY (SEGURIDAD CONTRA NULOS) EN DART
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * Uno de los errores más comunes y catastróficos en el desarrollo de software
 * es la famosa "Excepción de Puntero Nulo" (NullPointerException). Históricamente
 * denominada por su creador Tony Hoare como el "error de los mil millones de dólares".
 * Ocurre cuando intentas acceder a un método o propiedad de un objeto que es nulo (inexistente).
 * 
 * Dart soluciona esto mediante "Sound Null Safety" (Seguridad contra nulos garantizada).
 * El compilador de Dart separa de manera estricta los tipos de datos en dos universos:
 * 1. Tipos no-nulables (por defecto): NUNCA pueden almacenar nulo. El compilador lo impide.
 * 2. Tipos nulables: Pueden almacenar nulo, pero obligan al programador a realizar comprobaciones
 *    de seguridad antes de acceder a sus propiedades.
 */

void main() {
  print('=== TEORÍA Y EJEMPLOS: SOUND NULL SAFETY ===');

  /**
   * 1. TIPOS NO-NULABLES POR DEFECTO
   * 
   * Definición: En Dart, cualquier variable estándar (como String, int, bool) no puede ser nula.
   * Si intentas asignarle nulo, el compilador detendrá el proceso inmediatamente, garantizando
   * que la variable siempre tendrá un valor real y seguro en tiempo de ejecución.
   */
  String nombre = 'Camila';
  print('Nombre inicial: $nombre');
  // nombre = null; // ERROR DE COMPILACIÓN: A value of type 'Null' can't be assigned to a variable of type 'String'.

  /**
   * 2. TIPOS NULABLES Y EL OPERADOR '?'
   * 
   * Definición: Para indicar que una variable tiene permitido estar vacía (nula),
   * debemos añadir el sufijo '?' al tipo de dato. Esto le indica al analizador que
   * debe vigilar esta variable de cerca para evitar que llames a métodos suyos directamente.
   */
  String? usuarioActual = obtenerUsuarioNulable();
  print('Usuario actual: $usuarioActual'); // Imprime 'null' en consola.

  /**
   * 3. OPERADOR DE COALESCENCIA NULA '??' (Null Coalescing Operator)
   * 
   * Definición: Es un atajo para definir valores alternativos por defecto. Evalúa la expresión
   * de la izquierda; si no es nula, la retorna; si es nula, retorna la expresión de la derecha.
   */
  String nombreMostrar = usuarioActual ?? 'Invitado';
  print('Bienvenido, $nombreMostrar'); // Imprime 'Invitado' porque usuarioActual era null.

  /**
   * 4. ACCESO CONDICIONAL SEGURO '?.' (Null-Aware Member Access)
   * 
   * Definición: Ejecuta el método o propiedad posterior únicamente si la variable de la izquierda
   * no es nula. Si es nula, frena la evaluación y retorna directamente null en vez de reventar
   * el programa con una excepción de puntero nulo.
   */
  print('Longitud de usuario: ${usuarioActual?.length}'); // Retorna null de forma segura.

  // Asignamos un valor real para ver el flujo alternativo
  usuarioActual = 'Juan Pérez';

  /**
   * 5. OPERADOR DE ASERCIÓN NO NULA '!' (Bang Operator)
   * 
   * Definición: Se coloca al final de una variable nulable para forzarla a comportarse como no-nulable.
   * Es una promesa que le haces al compilador: "Te garantizo que esta variable NO es nula ahora".
   * 
   * PELIGRO TEÓRICO: Si el programador se equivoca y la variable es realmente nula en ese instante,
   * la aplicación lanzará un error fatal (NullThrownError) y se cerrará inmediatamente. Por buena
   * práctica, debe evitarse su uso a menos que sea 100% indispensable.
   */
  // ignore: unnecessary_non_null_assertion
  String usuarioObligatorio = usuarioActual!;
  print('Usuario confirmado: $usuarioObligatorio');

  /**
   * 6. INICIALIZACIÓN TARDÍA 'late' (Late Initialization)
   * 
   * Definición: Es una directiva que le promete al analizador estático que la variable
   * se inicializará después, antes de ser leída por primera vez. Esto permite saltarse
   * las comprobaciones inmediatas del compilador.
   * 
   * ¿Por qué es vital en Flutter?:
   * En Flutter, las pantallas tienen un ciclo de vida. Los widgets se crean en memoria
   * a través de su constructor, pero muchos objetos (como controladores de texto,
   * controladores de animación o clientes HTTP) necesitan inicializarse en un método
   * especial de inicialización llamado 'initState()'. Como no están listos en el constructor,
   * los declaramos como 'late' y los inicializamos de forma segura en el 'initState()'.
   * 
   * PELIGRO: Si intentas leer una variable 'late' antes de asignarle un valor, arrojará
   * un 'LateInitializationError' en tiempo de ejecución.
   */
  late String configuracionServidor;
  
  // Inicialización diferida (ocurre más adelante en el ciclo de vida del programa)
  configuracionServidor = 'https://api.cursoflutter.com';
  
  print('Servidor API: $configuracionServidor');
}

// Función auxiliar que simula el retorno de un dato que podría no existir (nulo)
String? obtenerUsuarioNulable() => null;
