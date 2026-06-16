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
  // Inicialización de la clase de servicios API
  final ApiService _apiService = ApiService();
  
  // Future que contendrá el resultado asíncrono
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    // Inicia la petición de red en el initState para que ocurra una sola vez cuando se monte el widget
    _loadUsers();
  }

  // Método que actualiza la variable del Future con una nueva petición para recargar la UI
  void _loadUsers() {
    setState(() {
      _usersFuture = _apiService.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers, // Llama al método para recargar el listado
          )
        ],
      ),
      // FutureBuilder simplifica el manejo de operaciones asíncronas directamente en la UI.
      // Se redibuja automáticamente en base al estado del Future provisto (loading, success, error)
      body: FutureBuilder<List<User>>(
        future: _usersFuture, // Escucha los cambios del Future de usuarios
        builder: (context, snapshot) {
          // ESTADO 1: Cargando datos (Conexión activa esperando respuesta)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // ESTADO 2: Error en la carga (Falló el API o no hay internet)
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(
                      // Remueve la palabra reservada 'Exception: ' para que se vea más estético el error
                      '${snapshot.error}'.replaceAll('Exception: ', ''),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _loadUsers,
                      icon: const Icon(Icons.replay),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }
          // ESTADO 3: Petición correcta pero los datos regresaron vacíos
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles.'));
          }

          // ESTADO 4: Petición correcta y contiene datos (snapshot.data)
          final users = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade700,
                    child: Text(
                      user.name[0], // Primera letra del nombre para simular avatar circular
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.alternate_email, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(user.username, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(user.email, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.business, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(user.companyName, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
