void main() {
  final usuario1 = Usuario(nombre: 'Carlos', edad: 30);
  print('Usuario 1: ${usuario1.nombre}, Edad: ${usuario1.edad}');

  final usuarioInvitado = Usuario.invitado();
  print('Invitado: ${usuarioInvitado.nombre}, Rol: ${usuarioInvitado.rol}');

  final usuarioAdmin = Usuario.administrador('Camila');
  print('Admin: ${usuarioAdmin.nombre}, Rol: ${usuarioAdmin.rol}');

  final jsonRecibido = {'nombre': 'Lucía', 'edad': 24};
  final usuarioDesdeJson = Usuario.fromJson(jsonRecibido);
  print('Usuario desde JSON: ${usuarioDesdeJson.nombre}, Edad: ${usuarioDesdeJson.edad}');

  final cuenta = CuentaBancaria(100.0);
  cuenta.depositar = 50.0;
  print('Balance actual: \$${cuenta.balance}');
}

class Usuario {
  final String nombre;
  final int edad;
  final String rol;

  Usuario({
    required this.nombre,
    required this.edad,
    this.rol = 'Estudiante',
  });

  Usuario.invitado()
      : nombre = 'Invitado de Prueba',
        edad = 18,
        rol = 'Invitado';

  Usuario.administrador(String nombreAdmin)
      : nombre = nombreAdmin,
        edad = 35,
        rol = 'Administrador';

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final nombreMapeado = json['nombre'] as String? ?? 'Sin Nombre';
    final edadMapeada = json['edad'] as int? ?? 0;
    
    return Usuario(
      nombre: nombreMapeado,
      edad: edadMapeada,
      rol: 'Estudiante',
    );
  }
}

class CuentaBancaria {
  double _saldo;

  CuentaBancaria(this._saldo);

  double get balance => _saldo;

  set depositar(double monto) {
    if (monto > 0) {
      _saldo += monto;
    } else {
      print('El monto a depositar debe ser positivo.');
    }
  }
}
