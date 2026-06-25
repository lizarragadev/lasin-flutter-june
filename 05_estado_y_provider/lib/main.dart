import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'routes/app_routes.dart';

// =============================================================================
// INTRODUCCIÓN TEÓRICA A LA GESTIÓN DE ESTADO (STATE MANAGEMENT):
// En Flutter, la interfaz de usuario (UI) es declarativa. Esto significa que la UI
// se construye como una función matemática del estado actual de la aplicación:
//
//                          UI = f(Estado)
//
// Cuando el estado de la aplicación cambia, el framework se encarga de redibujar
// la interfaz para reflejar la nueva información. Existen dos tipos de estado:
// 1. Estado Efímero (Local): Pertenece a un solo widget (ej. la página activa en un
//    PageView o si un botón está presionado). Se resuelve usando [StatefulWidget] y [setState].
// 2. Estado de la Aplicación (Compartido/Global): Se comparte entre múltiples pantallas
//    o componentes lejanos del árbol de widgets (ej. el carrito de compras, sesión de usuario).
//
// ¿Por qué necesitamos un gestor de estado como 'Provider'?
// Si no lo usáramos, tendríamos que pasar el estado y sus callbacks como parámetros
// constructor por constructor a lo largo de todo el árbol de widgets. Esta mala práctica
// se conoce como "Prop Drilling", y dificulta el mantenimiento del código.
// 'Provider' resuelve esto implementando el patrón de inyección de dependencias
// sobre el widget especial [InheritedWidget] de Flutter.
// =============================================================================

void main() {
  // TEORÍA SOBRE EL WIDGET CHANGENOTIFIERPROVIDER:
  // [ChangeNotifierProvider] es el widget principal del paquete 'provider' diseñado para:
  // 1. Alojar una clase que hereda de [ChangeNotifier] (nuestro CartProvider).
  // 2. Escuchar automáticamente cuando este notifica cambios.
  // 3. Reconstruir a los widgets descendientes suscritos en el árbol.
  //
  // - [create]: Callback que instancia e inicializa el Provider. Se ejecuta de forma
  //   perezosa (lazyloading), es decir, solo cuando se intenta leer por primera vez en la UI.
  // - [child]: El subárbol de widgets (en este caso, MainApp) que tendrá acceso a este estado.
  //   Al colocarlo envolviendo a toda la aplicación, hacemos que CartProvider sea accesible
  //   desde cualquier pantalla (CatalogScreen, CartScreen, etc.) sin importar qué tan profunda sea su ruta.
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
        // Dibuja un tema adaptado con colores basados en una semilla azul, configurando un tema oscuro (dark mode).
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      // Mapeamos el sistema de navegación por rutas nombradas.
      // Damos acceso a la inicialización centralizada del enrutador de la aplicación.
      initialRoute: AppRoutes.catalog,
      routes: AppRoutes.getRoutes(),
    );
  }
}
