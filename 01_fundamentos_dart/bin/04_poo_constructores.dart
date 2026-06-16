// LECCIÓN 4: Clases, Constructores Nombrados y Factory en Dart

void main() {
  // 1. Instanciación estándar
  final usuario1 = Usuario(nombre: 'Carlos', edad: 30);
  print('Usuario 1: ${usuario1.nombre}, Edad: ${usuario1.edad}');

  // 2. Uso de Constructores Nombrados (Named Constructors)
  // Permiten definir múltiples formas de crear un objeto bajo una misma clase.
  // En Flutter los usas todo el tiempo:
  // - EdgeInsets.all(16)
  // - EdgeInsets.symmetric(horizontal: 8)
  // - IconData.fromMac(...)
  final usuarioInvitado = Usuario.invitado();
  print('Invitado: ${usuarioInvitado.nombre}, Rol: ${usuarioInvitado.rol}');

  final usuarioAdmin = Usuario.administrador('Camila');
  print('Admin: ${usuarioAdmin.nombre}, Rol: ${usuarioAdmin.rol}');

  // 3. Constructores de Fábrica (Factory Constructors)
  // Se comportan como constructores pero no crean necesariamente una nueva instancia de la clase.
  // Pueden retornar una instancia del cache, una subclase, o procesar lógica compleja de mapeo.
  // Es la forma estándar en Flutter para parsear JSONs a modelos:
  final jsonRecibido = {'nombre': 'Lucía', 'edad': 24};
  final usuarioDesdeJson = Usuario.fromJson(jsonRecibido);
  print('Usuario desde JSON: ${usuarioDesdeJson.nombre}, Edad: ${usuarioDesdeJson.edad}');

  // 4. Uso de Getters y Setters
  final cuenta = CuentaBancaria(100.0);
  cuenta.depositar = 50.0; // Usa el setter
  print('Balance actual: \$${cuenta.balance}'); // Usa el getter
}

class Usuario {
  final String nombre;
  final int edad;
  final String rol;

  // Constructor Principal con inicialización corta (Shorthand constructor)
  Usuario({
    required this.nombre,
    required this.edad,
    this.rol = 'Estudiante', // Valor por defecto
  });

  // 1. Constructor Nombrado (Named Constructor)
  // Sintaxis: Clase.nombreConstructor(...)
  Usuario.invitado()
      : nombre = 'Invitado de Prueba',
        edad = 18,
        rol = 'Invitado'; // Inicializador por lista (corre antes de que se cree el objeto)

  // Otro constructor nombrado que recibe parámetros
  Usuario.administrador(String nombreAdmin)
      : nombre = nombreAdmin,
        edad = 35,
        rol = 'Administrador';

  // 2. Constructor Factory (De fábrica)
  // Se usa la palabra clave 'factory'. No tiene acceso a 'this' porque se ejecuta antes de crear la instancia.
  factory Usuario.fromJson(Map<String, dynamic> json) {
    // Procesa y limpia los datos antes de llamar al constructor real
    final nombreMapeado = json['nombre'] as String? ?? 'Sin Nombre';
    final edadMapeada = json['edad'] as int? ?? 0;
    
    // Retorna la instancia de Usuario
    return Usuario(
      nombre: nombreMapeado,
      edad: edadMapeada,
      rol: 'Estudiante',
    );
  }
}

class CuentaBancaria {
  double _saldo; // Variable privada (el prefijo '_' indica que es privada al archivo)

  CuentaBancaria(this._saldo);

  // Getter: Expone el saldo de forma controlada sin permitir modificarlo directamente
  double get balance => _saldo;

  // Setter: Valida y modifica el saldo privado
  set depositar(double monto) {
    if (monto > 0) {
      _saldo += monto;
    } else {
      print('El monto a depositar debe ser positivo.');
    }
  }
}
