import 'package:flutter/material.dart';

/// Modelo que representa un producto o artículo dentro de nuestra tienda.
/// 
/// TEORÍA SOBRE INMUTABILIDAD EN MODELOS:
/// En el ecosistema de Flutter, es una excelente práctica que los modelos de datos
/// sean inmutables. Al declarar todos los atributos como [final], evitamos que se modifiquen
/// accidentalmente propiedades individuales del producto, obligando a realizar cualquier
/// cambio a través de copias o reasignaciones (lo cual es vital para el control de estados).
class Item {
  final String id;
  final String title;
  final double price;
  final Color color;

  // TEORÍA SOBRE CONSTRUCTORES CONST:
  // - [const]: Dibuja la instancia en tiempo de compilación y optimiza el consumo de memoria RAM.
  // - [required]: Garantiza que no se puedan crear objetos con valores nulos descontrolados.
  const Item({
    required this.id,
    required this.title,
    required this.price,
    required this.color,
  });
}

// Listado estático de simulación (Mock Data) para rellenar el catálogo en pantalla.
// Al declararlo como constante global inmutable, está disponible de manera eficiente en toda la app.
const List<Item> mockItems = [
  Item(id: '1', title: 'Camiseta Flutter', price: 20.00, color: Colors.blue),
  Item(id: '2', title: 'Taza Dart Mágica', price: 12.50, color: Colors.amber),
  Item(id: '3', title: 'Sudadera Dev Pro', price: 45.00, color: Colors.deepPurple),
  Item(id: '4', title: 'Pegatinas Dev Pack', price: 5.00, color: Colors.teal),
  Item(id: '5', title: 'Llavero Logotipo', price: 3.50, color: Colors.red),
  Item(id: '6', title: 'Gorra Dash Mascot', price: 18.00, color: Colors.orange),
];
