import 'package:flutter/material.dart';
import '../models/item.dart';

// La clase hereda de 'ChangeNotifier', lo que le permite publicar notificaciones
// a cualquier widget que esté escuchando (subscrito) a sus cambios.
class CartProvider extends ChangeNotifier {
  // Lista interna privada de productos en el carrito para evitar que sea modificada desde afuera directamente
  final List<Item> _items = [];

  // Getter público que expone una lista inmutable (de sólo lectura) utilizando List.unmodifiable
  List<Item> get items => List.unmodifiable(_items);

  // Getter que calcula el precio acumulado de todos los ítems usando la función de reducción 'fold'
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.price);

  // Método para agregar un producto al carrito
  void addItem(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
      
      // notifyListeners() es CRÍTICO: le dice a todos los widgets que estén suscritos (como badges de carrito,
      // listas o botones) que deben redibujarse inmediatamente porque los datos del modelo acaban de cambiar.
      notifyListeners();
    }
  }

  // Método para eliminar un producto del carrito
  void removeItem(Item item) {
    _items.remove(item);
    
    // Notifica el cambio a la UI para que se redibujen las listas y el total a pagar
    notifyListeners();
  }

  // Método para vaciar el carrito
  void clearCart() {
    _items.clear();
    
    // Notifica que el carrito quedó vacío
    notifyListeners();
  }
}
