import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Eventos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      
      // TEORÍA SOBRE PROPIEDADES DE RUTAS EN MATERIALAPP:
      // - [initialRoute]: Define el String de la ruta por donde arranca la aplicación (reemplaza a la propiedad 'home').
      // - [routes]: Recibe un mapa de tipo Map<String, WidgetBuilder> que asocia cada ruta nombrada con su pantalla.
      initialRoute: AppRoutes.home,
      routes: AppRoutes.getRoutes(),
    );
  }
}
