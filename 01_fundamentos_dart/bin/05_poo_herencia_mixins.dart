void main() {
  final miBoton = BotonRedondo(label: 'Confirmar');
  miBoton.renderizar();

  final servicioAutenticacion = EmailAuth();
  servicioAutenticacion.login('carlos@mail.com', '12345');

  final adminServicio = PanelControl();
  adminServicio.ejecutarAccionSegura();
}

abstract class WidgetUI {
  final String id;
  WidgetUI(this.id);

  void renderizar();

  void dispose() {
    print('Widget $id destruido de la memoria.');
  }
}

class BotonRedondo extends WidgetUI {
  final String label;

  BotonRedondo({required this.label}) : super('btn_$label');

  @override
  void renderizar() {
    print('Renderizando Botón Circular [$label] en pantalla.');
  }
}

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
  void logout() {
    print('Sesión de correo cerrada.');
  }
}

mixin Logger {
  void logInfo(String mensaje) {
    print('[INFO - ${DateTime.now()}]: $mensaje');
  }

  void logError(String error) {
    print('[ERROR - ALERTA CRÍTICA]: $error');
  }
}

class PanelControl with Logger {
  void ejecutarAccionSegura() {
    logInfo('Iniciando proceso crítico del panel...');
    logInfo('Proceso finalizado con éxito.');
  }
}
