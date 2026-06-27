import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/user_viewmodel.dart';
import 'views/users_screen.dart';

void main() {
  runApp(const MainApp());
}

/// =============================================================================
/// ARQUITECTURA MVVM - PUNTO DE ENTRADA (MAIN)
/// 
/// En esta aplicación de consumo de APIs estructurada con MVVM:
/// 1. **Inyección de Dependencia con Provider**:
///    Usamos [ChangeNotifierProvider] para instanciar e inyectar el [UserViewModel]
///    en la raíz de nuestra aplicación. Esto permite que cualquier widget
///    hijo (como [UsersScreen]) obtenga y observe el ViewModel fácilmente.
/// 2. **Tema de la Aplicación**:
///    Configuramos un tema moderno basado en colores Teal de Material 3 en modo oscuro.
/// =============================================================================
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Proveemos el UserViewModel al árbol completo de widgets
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(), // Instanciación perezosa (lazy creation) del ViewModel
      child: MaterialApp(
        title: 'Consumo de APIs y Almacenamiento Local',
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
