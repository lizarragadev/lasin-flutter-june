import 'package:flutter/material.dart';
import '../models/item.dart';

class CartProvider extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.price);

  void addItem(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
      // TODO: Notificar a los suscriptores
    }
  }

  void removeItem(Item item) {
    _items.remove(item);
    // TODO: Notificar a los suscriptores
  }

  void clearCart() {
    _items.clear();
    // TODO: Notificar a los suscriptores
  }
}
