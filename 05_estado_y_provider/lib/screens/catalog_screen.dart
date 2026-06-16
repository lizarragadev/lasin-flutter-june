import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch<T>() suscribe este widget a los cambios de 'CartProvider'.
    // Cada vez que el provider llame a 'notifyListeners()', este método build se volverá a ejecutar (rebuild).
    // Es ideal para leer datos que se van a pintar directamente en la UI.
    final cart = context.watch<CartProvider>();
    final int cartItemCount = cart.items.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda de Merch Flutter'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              // Dibuja un círculo indicador rojo sólo si hay productos dentro del carrito
              if (cartItemCount > 0)
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: mockItems.length,
        itemBuilder: (context, index) {
          final item = mockItems[index];
          // Comprueba si el ítem ya está agregado al carrito para saber si deshabilitar el botón
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
                      color: item.color.withOpacity(0.2),
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
                            // Si el producto está en el carrito, onPressed se define como null (deshabilita el botón)
                            onPressed: isInCart
                                ? null
                                : () {
                                    // context.read<T>() obtiene la instancia del Provider pero SIN suscribirse a los cambios.
                                    // Se debe usar SIEMPRE dentro de métodos/eventos (onPressed, onTap) para llamar acciones.
                                    // Esto optimiza el rendimiento porque evita redibujos innecesarios al presionar botones.
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
