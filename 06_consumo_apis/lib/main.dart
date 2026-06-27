import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO: Importar el viewmodel y la vista

void main() {
  runApp(const MainApp());
}

/// =============================================================================
/// ARQUITECTURA MVVM - SKELETON
/// 
/// TODO: Configurar la inyección y provisión del ViewModel:
/// 1. Envuelve a [MaterialApp] dentro de un [ChangeNotifierProvider].
/// 2. Pasa una instancia de [UserViewModel] al callback [create].
/// 3. Define la pantalla inicial ([home]) apuntando a [UsersScreen].
/// =============================================================================
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Configurar el Provider para proveer UserViewModel a toda la app
    return MaterialApp(
      title: 'Consumo de APIs (MVVM & Caché)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const Scaffold(
        body: Center(child: Text('Configurar Provider en main.dart')),
      ),
    );
  }
}
