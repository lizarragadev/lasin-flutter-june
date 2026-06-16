import 'package:flutter/material.dart';
// TODO: Importar la pantalla de resumen cuando esté lista

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  // TODO: Declarar el GlobalKey para el Formulario (GlobalKey<FormState>)
  // TODO: Declarar los TextEditingControllers para nombre, email y edad
  
  String _selectedTicket = 'General';
  final List<String> _tickets = ['General', 'VIP', 'Backstage Access'];
  String? _confirmationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro al Flutter Fest 2026'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner informativo
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.event,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flutter Fest 2026',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Text('Fecha: 24 de Octubre | Formato: Virtual'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TODO: Implementar el widget Form y sus validadores:
            // 1. Campo Nombre completo (TextFormField con validador de vacío)
            // 2. Campo Correo electrónico (TextFormField con validador de formato de email)
            // 3. Campo Edad (TextFormField con validador numérico >= 18)
            // 4. DropdownButtonFormField para elegir el tipo de ticket
            // 5. Botón de Registro que al presionar valide el formulario
            //    y navegue a la pantalla TicketSummaryScreen enviando los parámetros
            // 6. Al regresar (pop), obtener y mostrar el código de confirmación recibido en un banner/diálogo.
            
            const Center(
              child: Text(
                'Aquí se debe construir el Formulario interactivo.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),

            if (_confirmationCode != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  '¡Registro Exitoso! Código de Confirmación: $_confirmationCode',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
