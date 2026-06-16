import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Perfil Profesional',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar el diseño de la pantalla de perfil
    // Debe incluir:
    // - Un Scaffold con AppBar
    // - Una foto de perfil circular (CircleAvatar)
    // - Texto con nombre, profesión y descripción
    // - Una fila (Row) con botones de contacto o iconos de redes sociales
    // - Un botón para alternar el tema (para lo cual se convertirá a StatefulWidget)
    return const Scaffold(
      body: Center(
        child: Text('Hola! Aquí irá tu perfil profesional'),
      ),
    );
  }
}
