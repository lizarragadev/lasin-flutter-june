import 'package:flutter/material.dart';
import '../models/item.dart';

// =============================================================================
// TEORÍA SOBRE EL PATRÓN OBSERVADOR (OBSERVER PATTERN) Y CHANGENOTIFIER:
// [ChangeNotifier] es una clase ligera e integrada en el SDK de Flutter (dentro de
// foundation.dart) que proporciona una implementación nativa del Patrón Observador.
//
// ¿Cómo opera a bajo nivel?
// 1. **Registro**: Los widgets consumidores (como CatalogScreen o CartScreen) se
//    registran como "escuchas" o suscriptores de esta clase al acceder a ella.
// 2. **Notificación**: Cuando algún método de esta clase modifica la lista privada
//    de productos, llamamos a [notifyListeners()].
// 3. **Reconstrucción**: Este método recorre todos los widgets registrados y les
//    notifica de la mutación de datos. Esto le indica al framework que debe volver
//    a ejecutar el método `build()` en cada uno de ellos para refrescar la interfaz.
// =============================================================================
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
    // Evitamos duplicidad de artículos para mantener la consistencia del carrito
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
    // Notifica de inmediato a la interfaz para que el elemento desaparezca de la lista
    notifyListeners();
  }

  /// Vacía por completo el listado del carrito.
  void clearCart() {
    _items.clear();
    // Notifica el vaciado para regresar la UI a su estado inicial de "Carrito Vacío"
    notifyListeners();
  }
}
