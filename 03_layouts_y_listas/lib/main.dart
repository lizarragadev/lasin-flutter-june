import 'package:flutter/material.dart';
import 'data/mock_products.dart';
import 'models/product.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const MainApp());
}

/// [MainApp] inicializa el catálogo con una configuración de tema basada en Material 3,
/// utilizando un color semilla índigo y forzando el modo oscuro globalmente.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Genera la paleta de colores a partir del color semilla Indigo
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}

/// [CatalogScreen] es una pantalla con estado (StatefulWidget) debido a que
/// el usuario puede interactuar con el selector de categorías para filtrar la lista de productos.
/// La selección activa representa el estado mutable de la pantalla.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

/// Estado asociado a [CatalogScreen]. Maneja el filtro seleccionado y reconstruye la vista.
class _CatalogScreenState extends State<CatalogScreen> {
  // Estado local que almacena la categoría actualmente seleccionada.
  // Por defecto se muestran 'Todos' los productos.
  String selectedCategory = 'Todos';

  @override
  Widget build(BuildContext context) {
    // Filtrado reactivo en tiempo de ejecución:
    // Si la categoría seleccionada es 'Todos', se usa toda la lista estática.
    // De lo contrario, se usa el método 'where' de Iterable para filtrar
    // los productos cuya propiedad 'category' coincida exactamente con la seleccionada.
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
      
      // ----------------- MAQUETACIÓN RESPONSIVA Y CONTROL DE RESTRICCIONES -----------------
      //
      // TEORÍA DEL MOTOR DE DISEÑO EN FLUTTER:
      // "Constraints go down, sizes go up, parent sets position" (Las restricciones bajan,
      // los tamaños suben, el padre establece la posición).
      // 
      // [LayoutBuilder] es una herramienta crucial para el diseño responsivo.
      // A diferencia de otros builders, se ejecuta durante la fase de layout (maquetación) y no en la fase de construcción estándar.
      // Proporciona el [BuildContext] y las [BoxConstraints] impuestas por el padre directo.
      // Esto nos permite inspeccionar 'constraints.maxWidth' y decidir qué interfaz dibujar
      // dinámicamente según el ancho disponible en la pantalla (Ej. Tablets vs. Móviles).
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Si el ancho máximo de la pantalla es mayor a 600 píxeles lógicos,
          // consideramos el dispositivo como una pantalla ancha (Landscape/Tablet)
          // y adaptamos el número de columnas del Grid.
          final isWide = constraints.maxWidth > 600;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------- SELECTOR DE CATEGORÍAS HORIZONTAL -----------------
              // [Container] envolvente con altura fija para acotar la restricción vertical
              // de la lista interna. Sin un límite de altura, ListView lanzaría un error
              // de dimensiones infinitas (unbounded height) en su eje de scroll.
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 8),
                
                // [ListView.builder] es una lista dinámica y optimizada (renderizado perezoso).
                // En lugar de renderizar todos los elementos a la vez (lo que consumiría mucha memoria
                // si la lista fuera enorme), el builder solo instancia e infla los widgets que están
                // actualmente visibles en la porción de pantalla (viewport) más un pequeño margen.
                // A medida que el usuario hace scroll, los elementos salientes son destruidos o reciclados.
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Habilita el desplazamiento en sentido horizontal.
                  itemCount: categories.length, // Especifica el número total de elementos a construir.
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  
                  // Constructor perezoso por índice
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = cat == selectedCategory;
                    
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      // [ChoiceChip] es un widget interactivo de Material Design similar a una píldora
                      // que soporta estados seleccionado / no seleccionado.
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        // Al hacer clic sobre el chip se activa este evento callback.
                        onSelected: (val) {
                          if (val) {
                            // setState notifica al framework el cambio de categoría,
                            // forzando una reconstrucción de la UI con la lista filtrada.
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
              
              // Título de la sección
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Catálogo ($selectedCategory)',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              
              // ----------------- MALLA DE PRODUCTOS (GRIDVIEW) -----------------
              // [Expanded] indica a este widget que debe rellenar todo el espacio disponible sobrante
              // dentro del eje principal del flex padre (en este caso, el espacio vertical de la Column).
              // Sin Expanded, GridView lanzaría un error debido a que no tiene restricciones verticales
              // definidas y su tamaño intentaría ser infinito.
              Expanded(
                // [GridView.builder] crea una malla bidimensional perezosa. Al igual que ListView.builder,
                // optimiza el rendimiento cargando bajo demanda únicamente los elementos visibles en pantalla.
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  
                  // El [gridDelegate] controla la distribución y tamaño de las celdas de la malla.
                  // [SliverGridDelegateWithFixedCrossAxisCount] define un número estricto de columnas (crossAxisCount).
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // Número de columnas dinámico: 3 si la pantalla es ancha, 2 si es angosta (móvil normal).
                    crossAxisCount: isWide ? 3 : 2, 
                    crossAxisSpacing: 16, // Espacio de separación horizontal entre tarjetas.
                    mainAxisSpacing: 16, // Espacio de separación vertical entre tarjetas.
                    
                    // [childAspectRatio] define la relación de aspecto (ancho/alto) de las celdas del Grid.
                    // Una relación de 0.72 significa que el alto será mayor que el ancho (ancho = alto * 0.72).
                    // Esto es fundamental porque en un GridView, los hijos no pueden definir su propio tamaño;
                    // están obligados a rellenar las celdas generadas según esta proporción.
                    childAspectRatio: 0.72, 
                  ),
                  itemCount: filteredProducts.length,
                  
                  // Constructor de cada elemento de la malla
                  itemBuilder: (context, index) {
                    final Product product = filteredProducts[index];
                    
                    return Card(
                      // [clipBehavior.antiAlias] recorta el contenido de los widgets hijos (como imágenes)
                      // para que se ajusten perfectamente a los bordes curvos de la tarjeta (RoundedRectangleBorder).
                      clipBehavior: Clip.antiAlias, 
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      
                      child: Column(
                        // Estira a los hijos horizontalmente para cubrir todo el ancho de la tarjeta
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        
                        children: [
                          // ----------------- IMAGEN Y CALIFICACIÓN (STACK) -----------------
                          // [Expanded] en la mitad superior de la columna interna de la tarjeta.
                          // Garantiza que la imagen ocupe el máximo espacio vertical disponible de la mitad de la celda.
                          Expanded(
                            // [Stack] permite superponer múltiples widgets unos encima de otros en el eje Z.
                            // El primer hijo se dibuja al fondo y los siguientes se apilan encima.
                            child: Stack(
                              fit: StackFit.expand, // Obliga a los hijos del Stack a expandirse para llenar su área.
                              children: [
                                // Imagen del producto cargada de red.
                                Image.network(
                                  product.imageUrl,
                                  // [BoxFit.cover] redimensiona y recorta la imagen para rellenar completamente
                                  // el espacio asignado sin distorsionar su relación de aspecto original.
                                  fit: BoxFit.cover, 
                                ),
                                
                                // [Positioned] posiciona de forma absoluta un widget dentro del área de un [Stack].
                                // Se especifican coordenadas top, right, bottom y/o left.
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0x99000000), // Fondo translúcido oscuro (negro con 60% de opacidad).
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      // [mainAxisSize.min] evita que la fila ocupe todo el ancho horizontal disponible.
                                      // Se reduce al tamaño exacto de su contenido interno (icono + texto).
                                      mainAxisSize: MainAxisSize.min, 
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
                          
                          // ----------------- DETALLES DEL PRODUCTO -----------------
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Categoría en formato de texto pequeño y en mayúsculas
                                Text(
                                  product.category.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    // Búsqueda de color primario heredado del tema global
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                                const SizedBox(height: 4),
                                
                                // Nombre del producto
                                Text(
                                  product.name,
                                  maxLines: 1, // Limita el texto a una sola línea.
                                  // [TextOverflow.ellipsis] corta el texto sobrante que excede los límites visuales
                                  // y le añade puntos suspensivos (...) para prevenir el desbordamiento de píxeles.
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                
                                const SizedBox(height: 4),
                                
                                // Descripción corta del producto
                                Text(
                                  product.description,
                                  maxLines: 2, // Limita la descripción a dos líneas.
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                                ),
                                
                                const SizedBox(height: 8),
                                
                                // Fila de precio e icono de compra
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // Formatea el valor de tipo double a string con dos decimales exactos.
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
