import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(
    // ChangeNotifierProvider inicializa el CartProvider y lo pone a disposición de todos
    // los widgets hijos dentro del árbol. Cualquier widget dentro de 'MainApp' o 'CatalogScreen'
    // podrá acceder al estado del carrito.
    ChangeNotifierProvider(
      create: (context) => CartProvider(), // Crea la instancia única de CartProvider
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}
