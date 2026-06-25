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
  // Identificadores de texto para las pantallas.
  // Por convención, la ruta inicial siempre es '/'
  static const String home = '/';
  static const String summary = '/summary';

  /// Retorna el mapa de rutas requerido por la propiedad 'routes' de MaterialApp.
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const EventFormScreen(),
      summary: (context) => const TicketSummaryScreen(),
    };
  }
}
