import 'package:flutter/material.dart';

class Item {
  final String id;
  final String title;
  final double price;
  final Color color;

  const Item({
    required this.id,
    required this.title,
    required this.price,
    required this.color,
  });
}

const List<Item> mockItems = [
  Item(id: '1', title: 'Camiseta Flutter', price: 20.00, color: Colors.blue),
  Item(id: '2', title: 'Taza Dart Mágica', price: 12.50, color: Colors.amber),
  Item(id: '3', title: 'Sudadera Dev Pro', price: 45.00, color: Colors.deepPurple),
  Item(id: '4', title: 'Pegatinas Dev Pack', price: 5.00, color: Colors.teal),
  Item(id: '5', title: 'Llavero Logotipo', price: 3.50, color: Colors.red),
  Item(id: '6', title: 'Gorra Dash Mascot', price: 18.00, color: Colors.orange),
];
