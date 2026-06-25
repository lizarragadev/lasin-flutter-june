import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'routes/app_routes.dart';

void main() {
  // TEORÍA SOBRE CHANGENOTIFIERPROVIDER:
  // [ChangeNotifierProvider] es el widget de conveniencia del paquete 'provider'
  // que conecta un [ChangeNotifier] (nuestro CartProvider) con el árbol de widgets.
  // - [create]: Se encarga de instanciar e inicializar el Provider de forma perezosa.
  // - Al colocarlo en la raíz (envolviendo a MainApp), garantizamos que cualquier pantalla
  //   hija dentro del MaterialApp pueda acceder al mismo estado del carrito.
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
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
      // Mapeamos el sistema de navegación por rutas nombradas.
      initialRoute: AppRoutes.catalog,
      routes: AppRoutes.getRoutes(),
    );
  }
}
