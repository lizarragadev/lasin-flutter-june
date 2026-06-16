// LECCIÓN 4: Clases, Constructores Nombrados y Factory en Dart

void main() {
  // TODO: 1. Instanciar Usuario usando el constructor principal e imprimir sus propiedades.

  // TODO: 2. Instanciar Usuario usando el constructor nombrado Usuario.invitado() e imprimir.

  // TODO: 3. Instanciar Usuario usando el constructor nombrado Usuario.administrador('nombre') e imprimir.

  // TODO: 4. Instanciar un Usuario desde un mapa JSON ficticio usando el constructor factory de la clase.

  // TODO: 5. Crear una cuenta bancaria con saldo inicial de 100.0.
  // Depositar dinero usando el setter y mostrar el saldo final usando el getter.
}

class Usuario {
  final String nombre;
  final int edad;
  final String rol;

  // TODO: Crear el constructor principal corto (shorthand constructor)
  // con parámetros requeridos nombrados (nombre, edad) y rol opcional (defecto 'Estudiante').

  // TODO: Crear el constructor nombrado 'invitado' inicializando nombre='Invitado de Prueba', edad=18, rol='Invitado'

  // TODO: Crear el constructor nombrado 'administrador' que reciba un String nombreAdmin y asigne edad=35, rol='Administrador'

  // TODO: Crear un constructor de fábrica 'factory Usuario.fromJson' que reciba un Map<String, dynamic> json
  // y devuelva un nuevo objeto Usuario inicializado con los datos mapeados.
}

class CuentaBancaria {
  double _saldo;

  CuentaBancaria(this._saldo);

  // TODO: Implementar el getter 'balance' que devuelva el saldo privado.

  // TODO: Implementar el setter 'depositar' que aumente el saldo sólo si el monto es positivo.
}
