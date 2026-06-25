import 'package:flutter/material.dart';
import '../models/item.dart';

/// Clase proveedora del estado del carrito de compras.
/// 
/// TEORÍA SOBRE CHANGENOTIFIER:
/// [ChangeNotifier] es una clase simple incluida en el SDK de Flutter que provee notificaciones de cambio a sus suscriptores.
/// Al heredar de ChangeNotifier, obtenemos el método [notifyListeners].
/// Cuando mutamos los datos internos del carrito (como agregar o quitar productos), llamamos a [notifyListeners()]
/// para indicarle al paquete 'provider' que reconstruya todos los widgets que estén "escuchando" o consumiendo este estado.
class CartProvider extends ChangeNotifier {
  // Lista privada mutable de elementos en el carrito.
  final List<Item> _items = [];

  // Exponemos la lista como inmutable para asegurar que nadie modifique los datos
  // fuera de los métodos autorizados de esta clase (Encapsulamiento).
  List<Item> get items => List.unmodifiable(_items);

  /// Calcula dinámicamente la sumatoria de precios de los elementos en el carrito.
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.price);

  /// Agrega un elemento al carrito si no existe previamente y notifica el cambio.
  void addItem(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
      // Al llamar a notifyListeners, todos los widgets suscritos (como el badge en CatalogScreen
      // o la lista de CartScreen) volverán a ejecutar sus métodos 'build' con el nuevo estado.
      notifyListeners();
    }
  }

  /// Remueve un elemento del carrito y notifica el cambio.
  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  /// Vacía por completo el listado del carrito.
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
