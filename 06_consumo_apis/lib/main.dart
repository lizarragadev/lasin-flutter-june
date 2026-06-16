import 'package:flutter/material.dart';
import 'models/user.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo de APIs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const UsersScreen(),
    );
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // TODO: Instanciar el ApiService
  
  // TODO: Declarar un Future<List<User>> para almacenar el resultado de la petición
  // e inicializarlo en el initState() para evitar llamados innecesarios en cada build.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: Refrescar la petición llamando nuevamente al API
            },
          )
        ],
      ),
      // TODO: Implementar el FutureBuilder para gestionar los estados asíncronos:
      // 1. Estado de carga: Mostrar CircularProgressIndicator
      // 2. Estado de error: Mostrar mensaje de error con un botón para reintentar
      // 3. Estado con datos: Mostrar un ListView con tarjetas hermosas para cada usuario
      //    (usando ListTile, Card, Icons.person, etc.)
      body: const Center(
        child: Text('Consumir API e implementar FutureBuilder aquí'),
      ),
    );
  }
}
