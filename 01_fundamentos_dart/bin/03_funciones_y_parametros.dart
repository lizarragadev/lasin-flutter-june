void main() {
  saludarPosicional('Juan', 25);

  saludarNombrado(
    nombre: 'Ana',
    edad: 28,
    esPremium: true,
  );

  print('El doble de 10 es ${calcularDoble(10)}');

  ejecutarOperacion(5, 4, (resultado) {
    print('Callback ejecutado. El resultado de la operación es: $resultado');
  });

  ejecutarOperacion(10, 10, (res) => print('Multiplicación rápida: $res'));
}

void saludarPosicional(String nombre, int edad) {
  print('Hola $nombre, tienes $edad años.');
}

void saludarNombrado({
  required String nombre,
  required int edad,
  bool esPremium = false,
}) {
  print('Usuario: $nombre | Edad: $edad | Suscripción Premium: $esPremium');
}

int calcularDoble(int numero) => numero * 2;

void ejecutarOperacion(int a, int b, void Function(int) operacion) {
  final suma = a + b;
  operacion(suma);
}
