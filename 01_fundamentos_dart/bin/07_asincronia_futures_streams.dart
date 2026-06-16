// LECCIÓN 7: Programación Asíncrona (Futures, async/await y Streams)

void main() async {
  // ==========================================
  // SECCIÓN 1: Futures y async/await
  // ==========================================
  // Un Future representa una promesa de que un valor se resolverá o fallará en el futuro (peticiones API, archivos, etc.)
  // En Flutter los consumes usando 'FutureBuilder'.
  
  print('1. Solicitando clima actual...');
  
  try {
    // 'await' pausa la ejecución hasta que la petición finalice. Obliga a que la función que lo contiene sea 'async'
    final clima = await obtenerClimaServidor();
    print('2. Clima recibido: $clima');
  } catch (e) {
    // try-catch captura errores en la petición de red (ej: sin conexión) de forma controlada
    print('Error capturado: $e');
  }

  // ==========================================
  // SECCIÓN 2: Streams (Flujos constantes de datos)
  // ==========================================
  // Un Stream es una secuencia de eventos asíncronos. A diferencia de un Future que retorna un único valor y finaliza,
  // un Stream puede retornar múltiples valores a lo largo del tiempo (ej: ticks de un reloj, chat en tiempo real, web sockets).
  // En Flutter, los consumes con 'StreamBuilder' o en patrones de arquitectura reactiva como BLoC.

  print('\n3. Iniciando cronómetro de descargas (Stream)...');
  
  final flujoDescargas = obtenerFlujoDescargas();

  // '.listen' se suscribe al Stream para recibir los datos a medida que se emiten
  flujoDescargas.listen(
    (porcentaje) {
      print('Descargando archivo: $porcentaje% completado...');
    },
    onDone: () {
      print('¡Stream finalizado! Archivo descargado con éxito.');
    },
    onError: (err) {
      print('Ocurrió un error en el flujo de descarga: $err');
    }
  );

  print('4. Fin del flujo principal (el Stream seguirá ejecutándose en segundo plano).');
}

// Función asíncrona que simula un retraso de red de 2 segundos
Future<String> obtenerClimaServidor() async {
  await Future.delayed(const Duration(seconds: 2));
  
  // Simulación de respuesta exitosa
  return 'Soleado, 25°C';
  
  // Simulación de error (Descomentar para probar el catch)
  // throw Exception('No se pudo establecer conexión con el servidor del clima.');
}

// Función que genera y retorna un Stream de enteros
Stream<int> obtenerFlujoDescargas() async* {
  // 'async*' (async generator) nos permite usar la palabra clave 'yield' para emitir múltiples valores
  for (int i = 20; i <= 100; i += 20) {
    await Future.delayed(const Duration(milliseconds: 800)); // Retraso entre descargas
    yield i; // Emite (envía) el valor al flujo de datos sin cerrar la función
  }
}
