import 'package:flutter/material.dart';
import '../screens/event_form_screen.dart';
import '../screens/ticket_summary_screen.dart';

/// Clase centralizada para la definición y mapeo de rutas de la aplicación.
/// 
/// TEORÍA SOBRE RUTAS NOMBRADAS:
/// Las rutas nombradas (Named Routes) permiten desacoplar la navegación de la implementación
/// directa de las pantallas. En lugar de instanciar un 'MaterialPageRoute' cada vez que queremos navegar,
/// definimos identificadores de texto estáticos (String keys) y los asociamos a constructores de widgets.
/// Esto facilita el mantenimiento, la navegación profunda y el enrutamiento dinámico en aplicaciones medianas/grandes.
class AppRoutes {
  // TEORÍA SOBRE PROPIEDADES ESTÁTICAS Y CONSTANTES:
  // - [static]: Hace que la variable pertenezca a la clase en sí y no a sus instancias. Se accede mediante 'AppRoutes.home'.
  // - [const]: Compilado en tiempo de construcción, garantizando que el String sea inmutable y altamente eficiente.
  // Por convención, la ruta inicial o pantalla de inicio de una aplicación Flutter siempre se define como '/'
  static const String home = '/';
  static const String summary = '/summary';

  /// Retorna el mapa de rutas requerido por la propiedad 'routes' de MaterialApp.
  /// 
  /// TEORÍA SOBRE MAPAS Y WIDGETBUILDER:
  /// Retorna un mapa `Map<String, WidgetBuilder>` donde:
  /// - `String` es la ruta clave (ej. '/summary').
  /// - `WidgetBuilder` es una función anónima `Widget Function(BuildContext)` encargada de instanciar la pantalla destino.
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const EventFormScreen(),
      summary: (context) => const TicketSummaryScreen(),
    };
  }
}
