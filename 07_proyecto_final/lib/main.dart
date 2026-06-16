import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/recipe_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(
    // ChangeNotifierProvider crea e inserta la instancia única de 'RecipeViewModel'
    // en la raíz del árbol, haciéndola accesible a cualquier vista (views) del proyecto.
    ChangeNotifierProvider(
      create: (context) => RecipeViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef Master MVVM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Define la paleta de colores del proyecto basada en un tono naranja (Chef/Comida)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
