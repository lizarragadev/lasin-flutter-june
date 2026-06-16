// LECCIÓN 2: Null Safety en Dart

void main() {
  // 1. Tipos no-nulables por defecto (Default)
  String nombre = 'Camila';
  print('Nombre inicial: $nombre');
  // nombre = null; // ERROR: No se puede asignar nulo a una variable de tipo String.

  // 2. Tipos nulables usando el operador '?'
  // Agregando '?' le indicamos a Dart que la variable acepta valores nulos.
  String? usuarioActual = obtenerUsuarioNulable();
  print('Usuario actual: $usuarioActual'); // Imprime null

  // 3. Operador de coalescencia nula '??'
  // Si el valor de la izquierda es nulo, asigna por defecto el valor de la derecha.
  String nombreMostrar = usuarioActual ?? 'Invitado';
  print('Bienvenido, $nombreMostrar'); // Imprime Invitado

  // 4. Acceso condicional seguro con '?.'
  // Ejecuta la propiedad sólo si el objeto no es nulo, evitando errores de puntero nulo.
  print('Longitud de usuario: ${usuarioActual?.length}'); // Imprime null sin reventar la app

  usuarioActual = 'Juan Pérez';

  // 5. Operador de aserción no nula '!' (Bajo tu propio riesgo)
  // Le asegura a Dart que la variable NO es nula en esta línea. 
  // Usa con cuidado, ya que si es nula provocará un crash en la aplicación.
  // ignore: unnecessary_non_null_assertion
  String usuarioObligatorio = usuarioActual!;
  print('Usuario confirmado: $usuarioObligatorio');

  // 6. Inicialización tardía con 'late'
  // Le dice a Dart: "Esta variable no se inicializa ahora, pero te garantizo que la inicializaré antes de usarla".
  // En Flutter se usa muchísimo en StatefulWidgets para inicializar TextEditingControllers o Animaciones en el initState.
  late String configuracionServidor;
  
  // Realizamos configuraciones previas...
  configuracionServidor = 'https://api.cursoflutter.com';
  
  // Ahora es seguro leer la variable
  print('Servidor API: $configuracionServidor');
}

String? obtenerUsuarioNulable() => null;
