// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';

/// =============================================================================
/// ARQUITECTURA MVVM - VISTA (UI) SKELETON
/// 
/// La Vista en MVVM es totalmente pasiva respecto a la lógica de negocio y persistencia:
/// 
/// TODO: Completar la visualización reactiva basándose en el estado del UserViewModel:
/// 1. Llama a `fetchUsers()` en el initState (usa WidgetsBinding si es necesario).
/// 2. Usa `context.watch<UserViewModel>()` para escuchar cambios.
/// 3. Muestra un banner informativo amarillo si `viewModel.isOffline` es verdadero.
/// 4. Muestra un CircularProgressIndicator cuando `viewModel.isLoading` y no hay datos.
/// 5. Muestra un botón de reintento si hay un error y la lista está vacía.
/// 6. Renderiza la lista de usuarios usando un ListView.builder.
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
