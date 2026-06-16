// LECCIÓN 5: Herencia, Clases Abstractas y Mixins en Dart

void main() {
  // TODO: 1. Instanciar un BotonRedondo con un label, llamar a renderizar() y dispose().

  // TODO: 2. Instanciar un EmailAuth, llamar a login() y logout().

  // TODO: 3. Instanciar un PanelControl y llamar a ejecutarAccionSegura() para ver la funcionalidad del Mixin Logger.
}

// TODO: Definir la clase abstracta WidgetUI con:
// - id (String)
// - Constructor inicializando el id
// - Método abstracto renderizar()
// - Método concreto dispose() que imprima que el widget se ha liberado de memoria.

// TODO: Crear la clase BotonRedondo que herede de WidgetUI ('extends'):
// - label (String)
// - Constructor que reciba label y llame a super con 'btn_$label'
// - Sobrescriba renderizar() para imprimir que se está dibujando en pantalla.

// TODO: Definir la interfaz abstracta Autenticacion con métodos login(email, pass) y logout().

// TODO: Crear la clase EmailAuth que implemente Autenticacion ('implements') y sobrescriba sus métodos.

// TODO: Crear el mixin Logger con métodos logInfo(mensaje) y logError(error).

// TODO: Crear la clase PanelControl que use el mixin Logger ('with') y llame a logInfo en sus métodos.
