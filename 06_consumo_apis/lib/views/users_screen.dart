import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';

/// =============================================================================
/// ARQUITECTURA MVVM - VISTA (UI)
/// 
/// La Vista en MVVM es totalmente pasiva respecto a la obtención de datos y lógica:
/// 1. **Suscripción Reactiva**: Escucha al ViewModel utilizando `context.watch<UserViewModel>()`.
/// 2. **Renderizado Condicional**: Reconstruye la pantalla según el estado
///    del ViewModel: cargando (`isLoading`), con error (`errorMessage`), u offline (`isOffline`).
/// 3. **Delegación**: Cuando se presiona "Reintentar" o se arrastra para refrescar,
///    se delega la acción llamando directamente a `viewModel.fetchUsers()`.
/// =============================================================================
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding ejecuta la petición inicial justo después de construir el primer frame.
    // Esto evita mutaciones de estado directas durante el ciclo de vida build().
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Escucha de forma reactiva al UserViewModel
    final viewModel = context.watch<UserViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            // Deshabilita el botón si está cargando activamente
            onPressed: viewModel.isLoading ? null : () => viewModel.fetchUsers(),
          )
        ],
      ),
      body: Column(
        children: [
          // Banner indicador de modo offline: se pinta si no hay conexión pero existen datos locales
          if (viewModel.isOffline && viewModel.users.isNotEmpty)
            Container(
              width: double.infinity,
              color: const Color(0xFFD84315),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  Icon(Icons.cloud_off, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Modo sin conexión: Mostrando caché guardada localmente.',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          
          // Renderiza el contenido principal basándose en el estado consolidado en el ViewModel
          Expanded(
            child: _buildContent(viewModel),
          ),
        ],
      ),
    );
  }

  /// Construye el widget adecuado para representar el estado del ViewModel
  Widget _buildContent(UserViewModel viewModel) {
    // 1. Estado: Cargando datos (y no hay datos previos para renderizar en pantalla)
    if (viewModel.isLoading && viewModel.users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando directorio...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    // 2. Estado: Error de carga (sin conexión y sin caché disponible)
    if (viewModel.errorMessage != null && viewModel.users.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, color: Colors.redAccent, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Error de conexión',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                viewModel.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => viewModel.fetchUsers(),
                icon: const Icon(Icons.refresh),
                label: const Text('Intentar de nuevo'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Estado: Éxito en la consulta pero la lista regresó vacía del API
    if (viewModel.users.isEmpty) {
      return const Center(
        child: Text('No hay usuarios disponibles en este momento.'),
      );
    }

    // 4. Estado: Éxito con datos. Muestra una lista deslizable con soporte de pull-to-refresh
    return RefreshIndicator(
      onRefresh: () => viewModel.fetchUsers(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: viewModel.users.length,
        itemBuilder: (context, index) {
          final user = viewModel.users[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade700,
                radius: 24,
                child: Text(
                  user.name[0], // Primera letra del nombre para simular avatar
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              title: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.alternate_email, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(user.username, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(user.email, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.business, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          user.companyName,
                          style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.teal),
            ),
          );
        },
      ),
    );
  }
}
