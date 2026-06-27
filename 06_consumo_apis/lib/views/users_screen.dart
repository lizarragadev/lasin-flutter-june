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
          IconButton(onPressed: () {
            viewModel.fetchUsers();
          }, icon: const Icon(Icons.refresh))
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
    return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: viewModel.users.length,
        itemBuilder: (context, index) {
          final user = viewModel.users[index];
          return Card(
            elevation: 4,
            child: ListTile(
              title: Text(user.name),
              subtitle: Text(user.username),
            ),
          );
        }
    );
  }
}
