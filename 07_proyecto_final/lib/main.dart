import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/recipe_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(
    // TODO: Proveer el RecipeViewModel a toda la aplicación usando ChangeNotifierProvider
    const MainApp(),
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
