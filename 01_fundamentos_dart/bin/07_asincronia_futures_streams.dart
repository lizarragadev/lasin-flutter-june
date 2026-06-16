// LECCIÓN 7: Programación Asíncrona (Futures, async/await y Streams)

void main() async {
  // TODO: 1. Llamar a la función asíncrona obtenerClimaServidor() usando await.
  // Envolver la llamada en un bloque try-catch para capturar errores de red y evitar caídas de la app.

  // TODO: 2. Llamar a la función obtenerFlujoDescargas() que retorna un Stream.
  // Usar flujoDescargas.listen(...) para suscribirse y recibir los porcentajes impresos en consola,
  // gestionando cuando finalice (onDone) y si hay error (onError).
}

// TODO: Crear la función asíncrona obtenerClimaServidor() que demore 2 segundos (usando Future.delayed)
// y retorne un Future<String> con valor 'Soleado, 25°C'.

// TODO: Crear la función obtenerFlujoDescargas() que retorne un Stream<int>.
// Debe emitir números del 20 al 100 de 20 en 20 con retardos intermedios usando yield (async*).
