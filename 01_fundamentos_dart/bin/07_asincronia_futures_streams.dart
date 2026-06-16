/**
 * ============================================================================
 * LECCIÓN 7: ASINCRONÍA AVANZADA - FUTURES, ASYNC/AWAIT Y STREAMS
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * A diferencia de otros lenguajes de servidor que usan hilos múltiples (multi-threading)
 * para manejar concurrencia, Dart es un lenguaje de un solo hilo (single-threaded).
 * Esto significa que tiene un único flujo de ejecución y un único espacio de memoria.
 * 
 * ¿Cómo maneja entonces Dart las operaciones pesadas (como leer archivos o descargar datos
 * de internet) sin congelar la pantalla?:
 * Lo hace mediante el "Bucle de Eventos" (Event Loop) y la programación asíncrona.
 * El Event Loop es un proceso infinito que vigila una cola de tareas (Event Queue).
 * Si hay una tarea lenta (como una petición HTTP), Dart la envía al sistema operativo en
 * segundo plano y sigue ejecutando la interfaz de usuario. Cuando la petición termina,
 * el sistema operativo coloca el resultado en la cola de eventos y Dart lo procesa sin
 * haber bloqueado la pantalla del usuario en ningún momento.
 * 
 * Para modelar estos datos asíncronos, Dart cuenta con dos clases Core:
 * 1. Future: Representa un único valor que estará disponible en el futuro (ej: respuesta API).
 * 2. Stream: Representa un flujo continuo de múltiples valores asíncronos a lo largo del tiempo
 *    (ej: chat en tiempo real, sensor GPS, porcentaje de descarga).
 */

void main() async {
  print('=== TEORÍA Y EJEMPLOS: ASINCRONÍA Y FLUJOS ===');

  /**
   * ==========================================================================
   * SECCIÓN 1: FUTURES Y ASYNC / AWAIT
   * ==========================================================================
   * 
   * Definición de 'async': Indica al compilador que la función contiene código asíncrono
   * y que siempre retornará un objeto Future, permitiendo además el uso de 'await'.
   * 
   * Definición de 'await': Pausa la ejecución secuencial de la función actual hasta que
   * el Future de la derecha se resuelva (tenga éxito o falle). Lo grandioso es que
   * pausa esa función, pero NO bloquea el resto de la aplicación ni congela la UI.
   * 
   * Manejo de Errores (try-catch):
   * Si la petición de red falla (por ejemplo, el servidor está caído o no hay internet),
   * el Future arroja una excepción. Envolver la llamada en un bloque 'try-catch' evita
   * que la aplicación se cierre abruptamente y nos permite mostrar un mensaje amigable al usuario.
   */
  print('1. Solicitando clima actual...');
  
  try {
    // Esperamos a que el Future termine de traer la información
    final clima = await obtenerClimaServidor();
    print('2. Clima recibido: $clima');
  } catch (e) {
    print('Error capturado en la petición de clima: $e');
  }

  /**
   * ==========================================================================
   * SECCIÓN 2: STREAMS (Flujos constantes de datos)
   * ==========================================================================
   * 
   * Diferencia Clave:
   * - Un Future devuelve una única respuesta y muere (ej: "Tráeme la temperatura de hoy").
   * - Un Stream es un grifo abierto que emite información constantemente (ej: "Avísame
   *   cada vez que cambie la temperatura").
   * 
   * Suscripción (.listen):
   * Para leer un Stream, nos suscribimos usando el método '.listen()'. Este recibe:
   * - data callback: Se ejecuta cada vez que el Stream emite un nuevo valor.
   * - onError: Se ejecuta si el flujo sufre un error intermedio.
   * - onDone: Se ejecuta cuando el Stream se cierra y no emitirá más datos.
   * 
   * Uso en Flutter:
   * Los Streams son la base de componentes reactivos en Flutter. Con el widget 'StreamBuilder',
   * puedes indicarle a tu pantalla que escuche un Stream y se redibuje automáticamente
   * cada vez que llegue un nuevo dato (por ejemplo, en un chat en vivo). Es también el pilar
   * del patrón de arquitectura BLoC (Business Logic Component).
   */
  print('\n3. Iniciando simulación de descarga (Stream)...');
  
  final flujoDescargas = obtenerFlujoDescargas();

  // Nos suscribimos para escuchar las emisiones del Stream
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

  print('4. Fin del bloque main (El Stream sigue emitiendo datos asíncronamente en segundo plano).');
}

/**
   * FUNCIÓN ASÍNCRONA QUE RETORNA UN FUTURE:
   * Retorna un Future<String>. Simula un retraso de 2 segundos mediante Future.delayed
   * para emular latencia de red.
   */
Future<String> obtenerClimaServidor() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Soleado, 25°C';
}

/**
   * GENERADOR DE STREAM (async*):
   * La sintaxis 'async*' (generador asíncrono) se utiliza para crear Streams.
   * En lugar de 'return', se usa la palabra clave 'yield'.
   * 
   * ¿Qué hace 'yield'?:
   * Envía el valor al flujo de datos (el Stream) pero no termina la ejecución de la función.
   * La función se pausa, emite el valor, y continúa en la siguiente iteración del bucle,
   * permitiendo enviar múltiples valores a lo largo del tiempo.
   */
Stream<int> obtenerFlujoDescargas() async* {
  for (int i = 20; i <= 100; i += 20) {
    await Future.delayed(const Duration(milliseconds: 800)); // Espera entre cada porcentaje
    yield i; // Emite el porcentaje actual al flujo sin salir de la función
  }
}
