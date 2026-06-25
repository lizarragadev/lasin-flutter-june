import 'package:flutter/material.dart';
import 'dart:math';
import '../models/registration_model.dart';

// TEORÍA SOBRE STATELESSWIDGET:
// Un [StatelessWidget] es un widget que no mantiene un estado interno mutable.
// Su interfaz se construye a partir de los datos recibidos (por ejemplo, argumentos de ruta)
// y no cambia dinámicamente a menos que todo el widget sea destruido y reconstruido por su padre.
// Es ideal para pantallas estáticas o de solo visualización de datos como esta de resumen.
class TicketSummaryScreen extends StatelessWidget {
  const TicketSummaryScreen({super.key});

  /// Genera un código de confirmación simulado.
  /// Utiliza la clase [Random] de 'dart:math' para generar un entero aleatorio
  /// entre 1000 y 9999, y lo devuelve con el prefijo 'FF-' (Flutter Fest).
  String _generateConfirmationCode() {
    final rand = Random();
    // rand.nextInt(9000) retorna un número entre 0 y 8999. Al sumarle 1000, aseguramos un rango [1000, 9999].
    final number = rand.nextInt(9000) + 1000;
    return 'FF-$number';
  }

  @override
  Widget build(BuildContext context) {
    // TEORÍA SOBRE LA RECUPERACIÓN DE ARGUMENTOS EN RUTAS NOMBRADAS:
    // [ModalRoute.of(context)] accede a la configuración de la ruta actual desde el árbol de elementos.
    // Mediante [.settings.arguments] obtenemos el objeto genérico enviado en el 'Navigator.pushNamed'.
    // El casteo mediante 'as RegistrationModel' es una aserción fuerte que le dice al analizador estático
    // de Dart que trate el objeto genérico con la firma del modelo, dándonos acceso inmediato a sus propiedades.
    final registration = ModalRoute.of(context)!.settings.arguments as RegistrationModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Por favor verifica tus datos antes de continuar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            // Tarjeta de ticket simulando un boleto de acceso.
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fila superior con el nombre del evento y el tipo de ticket
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FLUTTER FEST',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent, fontSize: 16),
                        ),
                        // Contenedor decorado para resaltar el tipo de entrada seleccionada (VIP, General, etc.)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            registration.ticketType.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    const Divider(height: 32), // Línea separadora decorativa estilo boleto
                    
                    const Text('Asistente:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(registration.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    
                    const Text('Correo:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(registration.email, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    
                    const Text('Edad:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('${registration.age} años', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Botón con icono para confirmar y regresar a la pantalla anterior
            ElevatedButton.icon(
              onPressed: () {
                // Generamos el código simulado al presionar confirmar
                final code = _generateConfirmationCode();
                
                // TEORÍA SOBRE NAVIGATOR.POP:
                // [Navigator.pop] desapila la pantalla actual del stack del navegador (cierra la pantalla).
                // El segundo argumento opcional (en este caso, 'code') es el valor que se le devuelve como respuesta
                // a la pantalla que la llamó (la cual estaba en espera usando 'await').
                Navigator.pop(context, code);
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Confirmar Entrada'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
