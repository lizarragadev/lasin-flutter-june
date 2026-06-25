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
  // Es privada (empieza con guion bajo `_`) para impedir manipulaciones externas descontroladas.
  final List<Item> _items = [];

  // TEORÍA SOBRE ENCAPSULAMIENTO Y LIST.UNMODIFIABLE:
  // Exponemos la lista interna a través de un getter público inmutable usando `List.unmodifiable(...)`.
  // - Si un desarrollador intenta hacer `cartProvider.items.add(otroItem)` desde una pantalla,
  //   el compilador lanzará una excepción inmediatamente en tiempo de ejecución.
  // - Toda alteración del estado debe forzosamente ocurrir a través de los métodos públicos autorizados
  //   (`addItem`, `removeItem`, `clearCart`), garantizando la integridad de los datos de la aplicación.
  List<Item> get items => List.unmodifiable(_items);

  // TEORÍA SOBRE EL MÉTODO FOLD:
  // [.fold] es un método utilitario de programación funcional en Dart para iterables.
  // - Recibe un valor inicial (en este caso, `0.0` para indicar punto flotante).
  // - Procesa cada elemento de la colección sumando el precio del artículo actual (`item.price`)
  //   al acumulador acumulado (`sum`), retornando el total consolidado.
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
