import 'package:flutter/material.dart';
// TODO: Importar provider, el viewmodel y la pantalla de detalle (detail_screen.dart)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: Disparar la carga inicial de recetas desde el ViewModel
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chef Master App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.restaurant_menu), text: 'Explorar Recetas'),
              Tab(icon: Icon(Icons.favorite), text: 'Mis Favoritas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Tab 1: Explorar Recetas
            // TODO: Agregar el buscador (TextField) y un ListView para las recetas del ViewModel.
            // Utilizar Consumer o Provider.of para reaccionar a los estados:
            // - Si está cargando: Mostrar CircularProgressIndicator
            // - Si hay error: Mostrar mensaje de error
            // - Si la lista está vacía: Mostrar un mensaje informativo
            // - Si hay datos: Mostrar las tarjetas con imagen, título, origen/cuisine y rating.
            Center(child: Text('Explorar Recetas (Skeleton)')),

            // Tab 2: Mis Favoritas
            // TODO: Mostrar la lista de recetas favoritas desde el ViewModel.
            Center(child: Text('Favoritos (Skeleton)')),
          ],
        ),
      ),
    );
  }
}
