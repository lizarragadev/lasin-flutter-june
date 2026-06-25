import 'package:flutter/material.dart';
import '../screens/catalog_screen.dart';
import '../screens/cart_screen.dart';

/// Definición y registro centralizado de las rutas de la aplicación de compras.
/// 
/// TEORÍA SOBRE ORGANIZACIÓN DE RUTAS EN STATE MANAGEMENT:
/// Centralizar las rutas en un solo archivo desacopla la lógica de navegación de los
/// widgets visuales. Esto es sumamente importante cuando el estado de la aplicación
/// (como el Carrito administrado por Provider) es compartido de forma global, permitiendo
/// abrir pantallas independientes sabiendo que todas acceden al mismo contexto de datos.
class AppRoutes {
  // TEORÍA SOBRE PROPIEDADES ESTÁTICAS Y CONSTANTES:
  // - [static]: Hace que la variable pertenezca a la clase en sí y no a sus instancias. Se accede mediante 'AppRoutes.catalog'.
  // - [const]: Compilado en tiempo de construcción, garantizando que el String sea inmutable y altamente eficiente.
  // Por convención, la ruta inicial o pantalla de inicio de una aplicación Flutter siempre se define como '/'
  static const String catalog = '/';
  static const String cart = '/cart';

  /// Retorna el mapa de rutas requerido por la propiedad 'routes' de MaterialApp.
  /// 
  /// TEORÍA SOBRE MAPAS Y WIDGETBUILDER:
  /// Retorna un mapa `Map<String, WidgetBuilder>` donde:
  /// - `String` es la ruta clave (ej. '/cart').
  /// - `WidgetBuilder` es una función anónima `Widget Function(BuildContext)` encargada de instanciar la pantalla destino.
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      catalog: (context) => const CatalogScreen(),
      cart: (context) => const CartScreen(),
    };
  }
}
