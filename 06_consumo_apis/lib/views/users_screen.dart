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
    // TODO: Disparar la carga inicial de usuarios delegando en el ViewModel
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Escuchar reactivamente al UserViewModel
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Usuarios'),
      ),
      body: const Center(
        child: Text('Implementar UI reactiva suscrita al ViewModel'),
      ),
    );
  }
}
