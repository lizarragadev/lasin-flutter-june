import 'package:flutter/material.dart';
import '../models/recipe.dart';
// TODO: Importar provider y el viewmodel

class DetailScreen extends StatelessWidget {
  final Recipe recipe;

  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // TODO: Obtener si la receta es favorita del ViewModel para alternar el icono del botón flotante

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen de la receta
            Hero(
              tag: 'recipe-img-${recipe.id}',
              child: Image.network(
                recipe.image,
                height: 250,
                fit: BoxFit.cover, // Nota: Asegúrate de importar o usar BoxFit.cover
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),

            // TODO: Diseñar el contenido de la receta:
            // 1. Duración (prep + cook time) en un Row con iconos (Icons.timer)
            // 2. Dificultad y Rating
            // 3. Lista de ingredientes (un bucle simple o Column con ListTile de ingredientes)
            // 4. Lista de instrucciones numeradas
            
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: Text('Instrucciones e ingredientes pendientes de vincular.'),
              ),
            ),
          ],
        ),
      ),
      // Botón flotante para alternar favorito
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Alternar favorito en el ViewModel
        },
        child: const Icon(Icons.favorite_border), // Cambiar dinámicamente
      ),
    );
  }
}
