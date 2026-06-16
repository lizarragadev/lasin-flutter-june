import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/recipe_viewmodel.dart';
import 'detail_screen.dart';

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
    // WidgetsBinding.instance.addPostFrameCallback asegura que la función se ejecute justo
    // después de que termine de renderizarse el primer frame de este widget.
    // Esto evita errores al invocar providers o triggers asíncronos antes del build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeViewModel>().loadRecipes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController administra el estado del TabBar y TabBarView automáticamente
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
        body: TabBarView(
          children: [
            // TAB 1: Explorar Recetas
            Column(
              children: [
                // Input de Búsqueda
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por receta o ingrediente...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          // Limpia la búsqueda en el ViewModel
                          context.read<RecipeViewModel>().filterRecipes('');
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) {
                      // Dispara la búsqueda reactiva en el ViewModel al escribir
                      context.read<RecipeViewModel>().filterRecipes(val);
                    },
                  ),
                ),
                // Contenido principal de recetas usando Consumer para reconstruir sólo esta sección
                Expanded(
                  child: Consumer<RecipeViewModel>(
                    builder: (context, vm, child) {
                      // Sub-estado 1: Cargando datos
                      if (vm.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // Sub-estado 2: Error en el llamado
                      if (vm.errorMessage != null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline, color: Colors.red, size: 50),
                                const SizedBox(height: 12),
                                Text(vm.errorMessage!, textAlign: TextAlign.center),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => vm.loadRecipes(),
                                  child: const Text('Reintentar'),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      // Sub-estado 3: Lista de recetas vacía (no se hallaron resultados)
                      if (vm.recipes.isEmpty) {
                        return const Center(child: Text('No se encontraron recetas.'));
                      }

                      // Sub-estado 4: Carga de recetas exitosa
                      return ListView.builder(
                        itemCount: vm.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = vm.recipes[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  recipe.image,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${recipe.cuisine} | ★ ${recipe.rating}'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(recipe: recipe),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // TAB 2: Mis Favoritas
            Consumer<RecipeViewModel>(
              builder: (context, vm, child) {
                // Si no tiene favoritas añadidas
                if (vm.favorites.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Aún no tienes recetas favoritas.', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }

                // Renderiza la lista de favoritas del usuario
                return ListView.builder(
                  itemCount: vm.favorites.length,
                  itemBuilder: (context, index) {
                    final recipe = vm.favorites[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            recipe.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${recipe.cuisine} | Dificultad: ${recipe.difficulty}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(recipe: recipe),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
