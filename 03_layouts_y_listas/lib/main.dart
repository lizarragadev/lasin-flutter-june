import 'package:flutter/material.dart';
import 'data/mock_products.dart';
import 'models/product.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // Estado que mantiene la categoría seleccionada por el usuario
  String selectedCategory = 'Todos';

  @override
  Widget build(BuildContext context) {
    // Operación ternaria de Dart para filtrar la lista de productos estáticos
    final filteredProducts = selectedCategory == 'Todos'
        ? mockProducts
        : mockProducts.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Tech Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      // LayoutBuilder proporciona las restricciones (constraints) de tamaño asignadas por el widget padre en tiempo de ejecución.
      // Esto nos permite tomar decisiones de renderizado adaptativas (responsivas) basadas en el ancho máximo disponible.
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determina si la pantalla es ancha (por ejemplo, tablets o pantallas horizontales)
          final isWide = constraints.maxWidth > 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contenedor que delimita la altura para el selector horizontal de categorías
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 8),
                // ListView.builder construye los elementos de forma perezosa (on-demand), ideal para listas largas u optimización de memoria.
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Dirección del scroll horizontal
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = cat == selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      // ChoiceChip representa un botón tipo píldora interactivo con estado de selección
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (val) {
                          if (val) {
                            // Cambia el estado del filtro de categorías, provocando que se repinte la pantalla
                            setState(() {
                              selectedCategory = cat;
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Catálogo ($selectedCategory)',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // Expanded indica al widget que tome todo el espacio vertical/horizontal sobrante dentro del Flex (Column/Row)
              Expanded(
                // GridView.builder renderiza los elementos en una malla bidimensional perezosa
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  // Controla cómo se distribuyen los elementos en la malla
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 3 : 2, // 3 columnas si es ancho, de lo contrario 2 columnas
                    crossAxisSpacing: 16, // Espaciado horizontal entre elementos
                    mainAxisSpacing: 16, // Espaciado vertical entre elementos
                    childAspectRatio: 0.72, // Relación ancho/alto de las tarjetas (aspect ratio)
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Card(
                      clipBehavior: Clip.antiAlias, // Recorta las esquinas del hijo para que se adapten a los bordes del Card
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Expanded toma la mitad superior para la imagen del producto
                          Expanded(
                            // Stack superpone múltiples elementos hijos uno sobre otro en profundidad (eje Z)
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover, // Redimensiona la imagen para rellenar el área sin deformar
                                ),
                                // Positioned coloca un widget de forma absoluta dentro de las coordenadas de un Stack
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min, // Se adapta al tamaño mínimo del contenido
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${product.rating}',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.category.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis, // Recorta el texto largo y añade puntos suspensivos (...)
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.between,
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(Icons.add_shopping_cart, size: 20, color: Colors.indigoAccent),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
