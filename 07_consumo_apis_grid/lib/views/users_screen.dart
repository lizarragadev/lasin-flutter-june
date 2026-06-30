// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio (StaggeredGrid)'),
        actions: [
          IconButton(
            onPressed: viewModel.isLoading ? null : () => viewModel.fetchUsers(), 
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          // Banner indicador de modo offline
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
          
          Expanded(child: _buildContent(viewModel))
        ],
      ),
    );
  }

  Widget _buildContent(UserViewModel viewModel) {
    if (viewModel.isLoading && viewModel.users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

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

    if (viewModel.users.isEmpty) {
      return const Center(child: Text('No hay usuarios disponibles.'));
    }

    // Usamos el widget StaggeredGrid.count para armar la rejilla de elementos.
    // Requiere estar dentro de un scroll (SingleChildScrollView) para manejar listas largas.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: StaggeredGrid.count(
        crossAxisCount: 2, // Define un total de 2 columnas de ancho
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(viewModel.users.length, (index) {
          final user = viewModel.users[index];
          // Asignamos una altura fija diferente a las tarjetas para generar el efecto staggered
          final double cardExtent = (index % 3 == 0) ? 140.0 : (index % 3 == 1 ? 180.0 : 120.0);
          
          return StaggeredGridTile.extent(
            crossAxisCellCount: 1, // Ocupa 1 de las 2 columnas de ancho
            mainAxisExtent: cardExtent, // Altura en píxeles lógicos
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.teal.shade700,
                              radius: 14,
                              child: Text(
                                user.name[0],
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                user.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '@${user.username}',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(height: 1),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.business, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                user.companyName,
                                style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
