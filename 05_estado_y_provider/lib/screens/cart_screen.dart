import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

// TEORÍA SOBRE ACCESO CENTRALIZADO Y REACTIVIDAD:
// CartScreen es un [StatelessWidget] porque la lógica reactiva se controla enteramente a través de
// `context.watch<CartProvider>()`. Si eliminamos un artículo, el proveedor notificará del cambio
// a esta pantalla haciendo que se vuelva a construir el árbol de widgets dinámicamente con los datos restantes.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos activamente los cambios del carrito para redibujar la lista si se quitan ítems
    final cart = context.watch<CartProvider>();
    final cartItems = cart.items;
    final double totalPrice = cart.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Carrito de Compras'),
        actions: [
          // Renderizamos el botón de vaciar carrito solo si el carrito no está vacío
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                // Ejecutamos la limpieza del carrito sin suscribirnos a reconstrucciones redundantes en el botón
                context.read<CartProvider>().clearCart();
              },
              tooltip: 'Vaciar Carrito',
            ),
        ],
      ),
      // RENDERIZADO CONDICIONAL DE PANTALLA:
      // Usamos un operador ternario para mostrar un aviso amigable si el carrito está vacío,
      // o el listado de compras con el total a pagar si tiene elementos.
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey.shade600),
                  const SizedBox(height: 16),
                  const Text(
                    '¡Tu carrito está vacío!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // TEORÍA SOBRE WIDGET EXPANDED Y VERTICAL VIEWPORT ERROR:
                // [Expanded] obliga al ListView a ocupar todo el espacio vertical disponible en la pantalla.
                // IMPORTANTE: Un [ListView] por definición tiene una altura ilimitada (unbounded height).
                // Si colocamos un ListView directamente dentro de una [Column] (que también tiene altura ilimitada),
                // Flutter arrojará un error de diseño catastrófico: "Vertical viewport was given unbounded height".
                // Envolver el ListView en un widget [Expanded] le comunica a Flutter que el tamaño vertical del
                // listado debe restringirse al espacio restante disponible en la columna, solucionando el error.
                Expanded(
                  // TEORÍA SOBRE LISTVIEW.BUILDER:
                  // Al igual que GridView.builder, renderiza celdas solo cuando se desplazan a la vista (lazy rendering).
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          // leading coloca un widget al inicio del ListTile (un círculo decorativo con el color del producto)
                          leading: CircleAvatar(
                            backgroundColor: item.color,
                            child: const Icon(Icons.shopping_bag, color: Colors.white),
                          ),
                          title: Text(item.title),
                          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                          // trailing coloca un widget al final (icono de basurero para eliminar el elemento)
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () {
                              // Ejecutamos la eliminación usando context.read
                              context.read<CartProvider>().removeItem(item);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Contenedor inferior de resumen y pago.
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x33000000), // Sombra con 20% de opacidad constante
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  // TEORÍA SOBRE EL WIDGET SAFEAREA:
                  // [SafeArea] agrega de manera inteligente el padding necesario para evitar interferir
                  // con zonas críticas del hardware en dispositivos móviles modernos (como el notch de la cámara,
                  // la barra inferior de gestos en iOS o muescas de esquinas).
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total a Pagar:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Procesamos la compra, vaciamos el carrito y enviamos una notificación
                            context.read<CartProvider>().clearCart();
                            
                            // TEORÍA SOBRE SCAFFOLDMESSENGER Y SNACKBAR:
                            // [ScaffoldMessenger] es la API encargada de administrar Snackbars y banners en pantalla.
                            // Al usar `ScaffoldMessenger.of(context).showSnackBar`, Flutter dibuja una alerta temporal
                            // flotante en la parte inferior de la pantalla sobre todo el árbol visual.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('¡Compra realizada con éxito!')),
                            );
                            // Regresa a la pantalla del catálogo de forma inmediata
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Proceder al Pago', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
