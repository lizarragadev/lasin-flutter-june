import 'package:flutter/material.dart';
import 'dart:math';
import '../models/registration_model.dart';

class TicketSummaryScreen extends StatelessWidget {
  const TicketSummaryScreen({super.key});

  /// Genera un código de confirmación simulado.
  String _generateConfirmationCode() {
    final rand = Random();
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
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FLUTTER FEST',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent, fontSize: 16),
                        ),
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
                    const Divider(height: 32),
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
            
            ElevatedButton.icon(
              onPressed: () {
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
