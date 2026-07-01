// ignore_for_file: unused_import
import 'package:flutter/material.dart';
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
        title: const Text('Directorio de Usuarios'),
        actions: [
          IconButton(
              onPressed: viewModel.isLoading ? null : () => viewModel.fetchUsers(),
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          if(viewModel.isOffline && viewModel.users.isNotEmpty)
            Container(
              width: double.infinity,
              color: const Color(0xFFD83454),
              padding: const EdgeInsets.all(8),
              child: const Row(
                children: [
                  Icon(Icons.cloud_off, color: Colors.white, size: 20,),
                  SizedBox(width: 10),
                  Expanded(child: Text(
                    "Modo sin conexión. Mostrando caché guardada localmente.",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ))
                ],
              ),
            ),
          Expanded(child: _buildContent(viewModel))
        ],
      ),
    );
  }

  Widget _buildContent(UserViewModel viewModel) {
    if(viewModel.isLoading && viewModel.users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Cargando datos...", style: TextStyle(color: Colors.grey),)
          ],
        ),
      );
    }
    if(viewModel.errorMessage != null && viewModel.users.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, color: Colors.redAccent, size: 64,),
              const SizedBox(height: 16),
              Text(
                viewModel.errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                  onPressed: () => viewModel.fetchUsers(),
                  icon: const Icon(Icons.refresh),
                  label: const Text("Intentar de nuevo"))
            ],
          ),
        ),
      );
    }

    if(viewModel.users.isEmpty) {
      return const Center(
        child: Text("No hay usuarios  disponibles en este momento."),
      );
    }

    return RefreshIndicator(
        onRefresh: () => viewModel.fetchUsers(),
        child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: viewModel.users.length,
            itemBuilder: (context, index) {
              final user = viewModel.users[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade700,
                    radius: 24,
                    child: Text(
                      user.name[0],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.alternate_email, size: 14, color: Colors.grey,),
                          Text(user.username)
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 14, color: Colors.grey,),
                          const SizedBox(width: 4,),
                          Text(user.email)
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          const Icon(Icons.business, size: 14, color: Colors.grey,),
                          const SizedBox(width: 4,),
                          Text(user.companyName)
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 14, color: Colors.teal,),
                ),
              );
            }
        )
    );
  }
}
