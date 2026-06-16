import 'package:flutter/material.dart';
import '../models/item.dart';

class CartProvider extends ChangeNotifier {
  // TODO: Declarar una lista privada de items seleccionados (_items)
  // TODO: Crear un getter público para obtener la lista inmutable (List<Item>)
  // TODO: Crear un getter para obtener el precio total sumando los precios de los items

  // TODO: Implementar el método para agregar un item a la lista
  // Recordar llamar a notifyListeners() para notificar a los consumidores
  void addItem(Item item) {
    // Código aquí
  }

  // TODO: Implementar el método para remover un item de la lista
  // Recordar llamar a notifyListeners()
  void removeItem(Item item) {
    // Código aquí
  }

  // TODO: Implementar el método para limpiar el carrito (vaciar lista)
  // Recordar llamar a notifyListeners()
  void clearCart() {
    // Código aquí
  }
}
