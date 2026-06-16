import 'package:flutter/material.dart';
import 'data/mock_products.dart';
import 'models/product.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String selectedCategory = 'Todos';

  @override
  Widget build(BuildContext context) {
    // Filtrar productos por categoría elegida
    final filteredProducts = selectedCategory == 'Todos'
        ? mockProducts
        : mockProducts.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Tech Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      // TODO: Implementar el diseño responsivo y la distribución usando Layouts:
      // 1. Selector de categorías horizontal (usando Row o ListView horizontal)
      // 2. Sección del catálogo usando GridView o ListView dinámico según el espacio (MediaQuery / LayoutBuilder)
      // 3. Tarjetas visuales hermosas (Card, ListTile, Stack, ClipRRect para imágenes redondeadas)
      body: const Center(
        child: Text('Diseña aquí tu catálogo de productos'),
      ),
    );
  }
}
