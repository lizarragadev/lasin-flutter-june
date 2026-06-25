import 'package:flutter/material.dart';
import '../screens/catalog_screen.dart';
import '../screens/cart_screen.dart';

class AppRoutes {
  static const String catalog = '/';
  static const String cart = '/cart';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      catalog: (context) => const CatalogScreen(),
      cart: (context) => const CartScreen(),
    };
  }
}
