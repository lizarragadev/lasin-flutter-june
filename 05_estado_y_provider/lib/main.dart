import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';

void main() {
  // TODO: Envolver la app en el ChangeNotifierProvider
  runApp(const MainApp());
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
