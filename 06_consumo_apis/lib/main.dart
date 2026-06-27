// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO: Importar el viewmodel y la vista

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Configurar el Provider para proveer UserViewModel a toda la app y UsersScreen como home
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
