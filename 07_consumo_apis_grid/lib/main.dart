// ignore_for_file: unused_import
import 'package:consumo_apis_grid/viewmodels/user_viewmodel.dart';
import 'package:consumo_apis_grid/views/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO: Importar el viewmodel y la vista
// MVVM - Model View ViewModel
// Model ---   ViewModel   ---  View

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: MaterialApp(
        title: 'Consumo de APIs (MVVM & Caché)',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        home: const UsersScreen(),
      ),
    );
  }
}
