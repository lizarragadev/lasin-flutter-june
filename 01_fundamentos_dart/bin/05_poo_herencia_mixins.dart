/**
 * ============================================================================
 * LECCIÓN 5: ESTRUCTURACIÓN POO AVANZADA - HERENCIA, INTERFACES Y MIXINS
 * ============================================================================
 * 
 * INTRODUCCIÓN TEÓRICA:
 * A medida que las aplicaciones crecen, la reutilización de código y la creación
 * de interfaces desacopladas se vuelven indispensables para mantener el código limpio.
 * Dart ofrece tres herramientas fundamentales para modularizar clases:
 * 
 * 1. HERENCIA (extends): Permite crear una jerarquía vertical de clases donde una subclase
 *    hereda los atributos y métodos de una superclase. (Ejemplo en Flutter: class MyWidget extends StatelessWidget).
 * 2. INTERFACES (implements): Dart no tiene la palabra reservada 'interface'. En su lugar,
 *    toda clase define implícitamente una interfaz. Al implementar otra clase, nos obligamos
 *    a redefinir absolutamente todos sus métodos y atributos.
 * 3. MIXINS (with): Permiten reutilizar código en múltiples jerarquías de clases sin herencia.
 *    Evita el "Problema del Diamante" de la herencia múltiple y añade comportamientos bajo demanda.
 */

void main() {
  print('=== TEORÍA Y EJEMPLOS: HERENCIA, INTERFACES Y MIXINS ===');

  // 1. Herencia y Overriding
  final miBoton = BotonRedondo(label: 'Confirmar');
  miBoton.renderizar(); // Ejecuta el método sobrescrito
  miBoton.dispose(); // Ejecuta el método heredado del padre

  // 2. Interfaces y Desacoplamiento
  final servicioAutenticacion = EmailAuth();
  servicioAutenticacion.login('carlos@mail.com', '12345');

  // 3. Mixins (with)
  final adminServicio = PanelControl();
  adminServicio.ejecutarAccionSegura(); // Accede a los métodos inyectados del Mixin Logger
}

// ==========================================================
// SECCIÓN 1: CLASES ABSTRACTAS Y HERENCIA (extends)
// ==========================================================

/**
 * CLASE ABSTRACTA:
 * Es una clase de diseño que no se puede instanciar (no puedes hacer WidgetUI()).
 * Sirve como molde base para definir propiedades comunes y forzar a las subclases
 * a implementar ciertos métodos.
 */
abstract class WidgetUI {
  final String id;
  WidgetUI(this.id);

  // Método abstracto: No tiene cuerpo '{}'. Cualquier hijo DEBE implementarlo obligatoriamente.
  void renderizar();

  // Método concreto: Ya tiene lógica. Las subclases lo heredan automáticamente sin necesidad de redefinirlo.
  void dispose() {
    print('Widget $id liberado correctamente de la memoria.');
  }
}

/**
 * SUBCLASE (BotonRedondo):
 * Usa 'extends' para heredar de WidgetUI.
 * '@override': Es una directiva al compilador indicando que estamos redefiniendo un método de la clase padre.
 * En Flutter, tu widget principal sobrescribe el método 'Widget build(BuildContext context)' heredado de StatelessWidget.
 */
class BotonRedondo extends WidgetUI {
  final String label;

  // Constructor que inicializa su propiedad y llama al constructor del padre mediante 'super'
  BotonRedondo({required this.label}) : super('btn_$label');

  @override
  void renderizar() {
    print('Renderizando Botón Circular [$label] en pantalla.');
  }
}

// ==========================================================
// SECCIÓN 2: INTERFACES (implements)
// ==========================================================

/**
 * CONCEPTO DE INTERFAZ IMPLÍCITA:
 * En Dart, cualquier clase o clase abstracta sirve como interfaz.
 * Al usar 'implements' en vez de 'extends', no heredamos código de la clase base.
 * En su lugar, tratamos a la clase base como un contrato: estamos obligados a implementar
 * cada uno de sus campos y firmas de método desde cero.
 * 
 * Uso en Flutter: Es ideal para pruebas unitarias (Testing). Si tienes un servicio de API
 * real, puedes implementar su interfaz para crear un Mock (simulador) de datos local
 * sin modificar la lógica de tus pantallas.
 */
abstract class Autenticacion {
  void login(String email, String password);
  void logout();
}

class EmailAuth implements Autenticacion {
  @override
  void login(String email, String password) {
    print('Autenticando usuario mediante email: $email');
  }

  @override
  @override
  void logout() {
    print('Sesión de correo cerrada.');
  }
}

// ==========================================================
// SECCIÓN 3: MIXINS (with)
// ==========================================================

/**
 * CONCEPTO DE MIXIN:
 * Un Mixin es una clase especial diseñada únicamente para compartir lógica entre múltiples
 * clases sin necesidad de herencia directa. Se declaran con la palabra clave 'mixin' y no
 * pueden tener constructores ni instanciarse directamente.
 * 
 * ¿Por qué no herencia múltiple?:
 * Muchos lenguajes prohíben la herencia múltiple porque si una clase hereda de A y B, y ambas
 * tienen un método llamado 'ejecutar()', la clase hija no sabe cuál llamar (Problema del Diamante).
 * Dart soluciona esto con Mixins lineales usando la palabra clave 'with'.
 * 
 * Uso en Flutter:
 * Las animaciones en Flutter requieren sincronizarse con la tasa de refresco de la pantalla (60Hz/120Hz).
 * Para alimentar esta señal de reloj (VSYNC) a tu controlador de animación, inyectas el mixin
 * 'SingleTickerProviderStateMixin' a tu clase de Estado:
 * class _MyState extends State<MyWidget> with SingleTickerProviderStateMixin
 */
mixin Logger {
  void logInfo(String mensaje) {
    print('[LOG - INFO - ${DateTime.now()}]: $mensaje');
  }

  void logError(String error) {
    print('[LOG - ERROR - ADVERTENCIA]: $error');
  }
}

// PanelControl hereda o implementa sus funciones base, pero inyecta los métodos del Mixin Logger
class PanelControl with Logger {
  void ejecutarAccionSegura() {
    logInfo('Iniciando proceso crítico en el panel administrativo...');
    // Proceso...
    logInfo('Proceso finalizado.');
  }
}
