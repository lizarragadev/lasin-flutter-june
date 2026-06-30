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
        title: const Text('Directorio (Grid/Staggered)'),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.fetchUsers();
            }, 
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildContent(viewModel))
        ],
      ),
    );
  }

  Widget _buildContent(UserViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.users.isEmpty) {
      return const Center(child: Text('No hay usuarios disponibles.'));
    }

    // TODO: Diseñar y modificar la estructura del elemento en el Staggered Grid
    // En este proyecto usamos MasonryGridView.count para generar un listado tipo mosaico (Pinterest)
    return MasonryGridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2, // Dos columnas
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: viewModel.users.length,
      itemBuilder: (context, index) {
        final user = viewModel.users[index];
        // Asignamos alturas variadas para simular el efecto staggered (mosaico)
        final double cardPadding = (index % 3 == 0) ? 16.0 : (index % 3 == 1 ? 24.0 : 32.0);
        
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal.shade700,
                  radius: 18,
                  child: Text(
                    user.name[0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user.username}',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                ),
                if (index % 2 == 0) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.business, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          user.companyName,
                          style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
