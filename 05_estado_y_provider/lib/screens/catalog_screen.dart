import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';
import '../routes/app_routes.dart';

// TEORÍA SOBRE RE-RENDERIZACIÓN EN STATELESSWIDGET CON PROVIDER:
// ¿Por qué esta pantalla es un [StatelessWidget] si el catálogo reacciona dinámicamente
// al agregar elementos o cambiar el contador del carrito?
// - No necesitamos un [StatefulWidget] local con `setState` porque delegamos toda la reactividad
//   a un Gestor de Estado externo (`CartProvider` a través de `Provider`).
// - Mediante `context.watch<CartProvider>()`, Flutter se encarga de suscribir el widget e invocar
//   el método build completo cada vez que el carrito emite notificaciones de cambio.
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TEORÍA COMPLETA SOBRE CONTEXT.WATCH Y CONTEXT.READ:
    // El paquete 'provider' expone extensiones de tipo en BuildContext para interactuar con el árbol.
    //
    // 1. [context.watch<T>()]:
    //    - Establece un vínculo de dependencia dinámico y bidireccional entre el widget y el Proveedor.
    //    - Cada vez que el Proveedor llame a 'notifyListeners()', este widget completo (desde esta línea hacia abajo)
    //      se marcará como "sucio" y se volverá a compilar en el siguiente frame.
    //    - USO: Obligatorio en la raíz del build o allí donde necesitemos leer datos que cambian con el tiempo (como la lista de compras).
    //
    // 2. [context.read<T>()]:
    //    - Obtiene la referencia directa al Proveedor de forma estática, SIN establecer ninguna suscripción.
    //    - Si los datos del Proveedor cambian, el widget NO se redibujará.
    //    - USO: Reservado exclusivamente para métodos dentro de botones, gestores de gestos u callbacks (como 'onPressed').
    //    - NOTA CLAVE DE RENDIMIENTO: Al usar context.read para ejecutar una acción (como 'addItem'), evitamos registrar
    //      un enlace innecesario. Si usáramos context.watch dentro de un botón (lo cual arrojaría error), el botón
    //      se reconstruiría inútilmente.
    final cart = context.watch<CartProvider>();
    final int cartItemCount = cart.items.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda de Merch Flutter'),
        actions: [
          // TEORÍA SOBRE EL WIDGET STACK:
          // [Stack] permite superponer múltiples widgets unos encima de otros en capas de adelante hacia atrás.
          // Aquí lo usamos para colocar el Badge (contador rojo de artículos) sobre la esquina del Icono de Carrito.
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navegación mediante ruta nombrada hacia el carrito.
                  Navigator.pushNamed(
                    context,
                    AppRoutes.cart,
                  );
                },
              ),
              // Renderizado condicional del badge: solo se dibuja si hay artículos en el carrito.
              if (cartItemCount > 0)
                // [Positioned] posiciona de forma absoluta un elemento dentro de un widget Stack.
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      // TEORÍA SOBRE GRIDVIEW.BUILDER:
      // [GridView.builder] renderiza una grilla bidimensional de manera perezosa (lazy).
      // Solo instanciará los widgets de las celdas que son físicamente visibles en la pantalla,
      // optimizando drásticamente el uso de memoria y rendimiento para listas o catálogos largos.
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        // [gridDelegate] define la estructura geométrica de la grilla.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dibuja exactamente 2 columnas
          crossAxisSpacing: 16, // Espaciado horizontal entre celdas
          mainAxisSpacing: 16, // Espaciado vertical entre celdas
          childAspectRatio: 0.8, // Proporción altura/anchura de las celdas (más altas que anchas)
        ),
        itemCount: mockItems.length,
        itemBuilder: (context, index) {
          final item = mockItems[index];
          // Validamos si este producto específico ya fue agregado al carrito
          final bool isInCart = cart.items.contains(item);

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // NOTA DE DEPRECACIÓN EVITADA:
                      // En versiones modernas de Flutter SDK, llamar a `color.withOpacity` en bucles de construcción
                      // constantes genera advertencias de optimización o está marcado como obsoleto.
                      // En su lugar, usamos `color.withAlpha(51)` (51 equivale a 20% de opacidad en una escala de 0 a 255)
                      // para lograr el mismo efecto visual translúcido de forma nativa y eficiente.
                      color: item.color.withAlpha(51),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      size: 60,
                      color: item.color,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isInCart ? Icons.check_circle : Icons.add_circle,
                              color: isInCart ? Colors.green : Colors.blue,
                            ),
                            // Si ya está en el carrito, deshabilitamos el botón pasando null a onPressed
                            onPressed: isInCart
                                ? null
                                : () {
                                    // Invocamos la acción addItem en el CartProvider sin generar dependencias de escucha.
                                    context.read<CartProvider>().addItem(item);
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
