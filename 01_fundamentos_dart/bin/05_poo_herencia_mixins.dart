// LECCIÓN 5: Herencia, Clases Abstractas y Mixins en Dart

void main() {
  // 1. Herencia y Overriding
  // En Flutter, tus vistas heredan de 'StatelessWidget' o 'StatefulWidget'
  // y sobrescriben el método build: @override Widget build(...)
  final miBoton = BotonRedondo(label: 'Confirmar');
  miBoton.renderizar(); // Imprime comportamiento heredado y sobrescrito

  // 2. Uso de Clases Abstractas e Interfaces
  // Sirven para definir "contratos" o comportamientos comunes que otras clases deben implementar.
  // Es la base de arquitecturas limpias para definir repositorios (ej: AuthRepository).
  final servicioAutenticacion = EmailAuth();
  servicioAutenticacion.login('carlos@mail.com', '12345');

  // 3. Mixins (Palabra clave 'with')
  // Permiten compartir código y métodos entre múltiples clases sin necesidad de usar herencia vertical directa.
  // En Flutter, verás Mixins cuando hagas animaciones:
  // class _MyScreenState extends State<MyScreen> with SingleTickerProviderStateMixin
  final adminServicio = PanelControl();
  adminServicio.ejecutarAccionSegura(); // Tiene acceso al método del Mixin Logger
}

// ==========================================
// SECCIÓN 1: Clases Abstractas y Herencia
// ==========================================

// Clase abstracta que no se puede instanciar directamente, define la base de los componentes UI
abstract class WidgetUI {
  final String id;
  WidgetUI(this.id);

  // Método abstracto (sin implementar) que cualquier hijo DEBE definir
  void renderizar();

  // Método concreto heredable
  void dispose() {
    print('Widget $id destruido de la memoria.');
  }
}

// BotonRedondo hereda de WidgetUI usando 'extends'
class BotonRedondo extends WidgetUI {
  final String label;

  // Constructor que inicializa los atributos locales y envía el ID al constructor padre usando 'super'
  BotonRedondo({required this.label}) : super('btn_$label');

  // Sobrescribe el comportamiento del método abstracto obligado
  @override
  void renderizar() {
    print('Renderizando Botón Circular [$label] en pantalla.');
  }
}

// ==========================================
// SECCIÓN 2: Interfaces
// ==========================================

// En Dart no existe la palabra clave 'interface'. Cualquier clase o clase abstracta puede usarse como interfaz
abstract class Autenticacion {
  void login(String email, String password);
  void logout();
}

// Implementación de la interfaz mediante 'implements'. Obliga a definir todos los métodos declarados
class EmailAuth implements Autenticacion {
  @override
  void login(String email, String password) {
    print('Autenticando usuario mediante email: $email');
  }

  @override
  void logout() {
    print('Sesión de correo cerrada.');
  }
}

// ==========================================
// SECCIÓN 3: Mixins (Compartir funcionalidad)
// ==========================================

// Un Mixin es una clase sin constructores que almacena métodos utilitarios reutilizables
mixin Logger {
  void logInfo(String mensaje) {
    print('[INFO - ${DateTime.now()}]: $mensaje');
  }

  void logError(String error) {
    print('[ERROR - ALERTA CRÍTICA]: $error');
  }
}

// Usamos 'with' para inyectar los métodos del Mixin dentro de PanelControl
class PanelControl with Logger {
  void ejecutarAccionSegura() {
    logInfo('Iniciando proceso crítico del panel...');
    // Lógica...
    logInfo('Proceso finalizado con éxito.');
  }
}
