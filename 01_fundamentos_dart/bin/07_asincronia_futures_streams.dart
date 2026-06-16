void main() async {
  print('1. Solicitando clima actual...');
  
  try {
    final clima = await obtenerClimaServidor();
    print('2. Clima recibido: $clima');
  } catch (e) {
    print('Error capturado: $e');
  }

  print('\n3. Iniciando cronómetro de descargas (Stream)...');
  
  final flujoDescargas = obtenerFlujoDescargas();

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

Future<String> obtenerClimaServidor() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Soleado, 25°C';
}

Stream<int> obtenerFlujoDescargas() async* {
  for (int i = 20; i <= 100; i += 20) {
    await Future.delayed(const Duration(milliseconds: 800));
    yield i;
  }
}
