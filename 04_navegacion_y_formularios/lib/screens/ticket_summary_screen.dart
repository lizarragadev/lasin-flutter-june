import 'package:flutter/material.dart';
import 'dart:math';

class TicketSummaryScreen extends StatelessWidget {
  // TODO: Recibir los datos enviados por la pantalla anterior
  // nombre (String), email (String), edad (int), ticketType (String) via constructor.
  
  const TicketSummaryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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

            // TODO: Crear una tarjeta de Ticket Visual
            // mostrando: Nombre, Correo, Edad y Tipo de Entrada
            
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(
                  child: Text('Datos del Ticket Pendientes de Vincular'),
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // TODO: Implementar el botón de Confirmar
            // Al hacer tap, debe retornar una cadena aleatoria (ej: "FF-8924") usando Navigator.pop
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigator.pop enviando el código de confirmación de retorno
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Confirmar Entrada'),
            ),
          ],
        ),
      ),
    );
  }
}
