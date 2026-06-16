void main() {
  String nombre = 'Camila';
  print('Nombre inicial: $nombre');

  String? usuarioActual = obtenerUsuarioNulable();
  print('Usuario actual: $usuarioActual');

  String nombreMostrar = usuarioActual ?? 'Invitado';
  print('Bienvenido, $nombreMostrar');

  print('Longitud de usuario: ${usuarioActual?.length}');

  usuarioActual = 'Juan Pérez';

  // ignore: unnecessary_non_null_assertion
  String usuarioObligatorio = usuarioActual!;
  print('Usuario confirmed: $usuarioObligatorio');

  late String configuracionServidor;
  
  configuracionServidor = 'https://api.cursoflutter.com';
  
  print('Servidor API: $configuracionServidor');
}

String? obtenerUsuarioNulable() => null;
