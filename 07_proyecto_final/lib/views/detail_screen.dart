import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../viewmodels/recipe_viewmodel.dart';

class DetailScreen extends StatelessWidget {
  final Recipe recipe;

  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // context.watch suscribe este widget a los cambios de 'RecipeViewModel'.
    // Redibuja el botón flotante (icono de corazón) si cambia el estado de favorito.
    final vm = context.watch<RecipeViewModel>();
    final isFav = vm.isFavorite(recipe);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widget Hero realiza animaciones de transición fluidas de la imagen
            // entre dos pantallas diferentes vinculadas por el mismo tag.
            Hero(
              tag: 'recipe-img-${recipe.id}',
              child: Image.network(
                recipe.image,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipe.cuisine,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text('${recipe.rating}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dificultad: ${recipe.difficulty}',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text('Prep: ${recipe.prepTimeMinutes} min'),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.cookie_outlined, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text('Cocción: ${recipe.cookTimeMinutes} min'),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Mapea y renderiza el listado de ingredientes
                  ...recipe.ingredients.map((ing) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: Colors.orange, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(ing)),
                          ],
                        ),
                      )),
                  const Divider(height: 32),
                  const Text(
                    'Instrucciones',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Mapea las instrucciones enumeradas utilizando .asMap() para obtener el índice idx
                  ...recipe.instructions.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.orange,
                            child: Text(
                              '$idx',
                              style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(step)),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      // Botón flotante para alternar favorito
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read se usa para invocar el trigger del toggle sin causar suscripción en el método onTap
          context.read<RecipeViewModel>().toggleFavorite(recipe);
        },
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : null,
        ),
      ),
    );
  }
}
