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
  static const String catalog = '/';
  static const String cart = '/cart';

  /// Mapea los identificadores de ruta con las pantallas del catálogo y el carrito.
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      catalog: (context) => const CatalogScreen(),
      cart: (context) => const CartScreen(),
    };
  }
}
