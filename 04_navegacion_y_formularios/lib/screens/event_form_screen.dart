import 'package:flutter/material.dart';
import 'ticket_summary_screen.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  // GlobalKey identifica de forma única a este formulario y nos permite acceder a su estado (validaciones, guardar valores)
  final _formKey = GlobalKey<FormState>();
  
  // TextEditingControllers permiten controlar, leer y modificar el texto dentro de los campos de texto
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  
  String _selectedTicket = 'General';
  final List<String> _tickets = ['General', 'VIP', 'Backstage Access'];
  String? _confirmationCode;

  // Método de ciclo de vida del Widget que destruye los controladores para liberar la memoria del teléfono al salir
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // Método asíncrono para enviar el formulario y esperar el código del ticket retornado
  void _submitForm() async {
    // Evalúa si todos los validadores de los TextFormField retornaron null (sin errores)
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final age = int.parse(_ageController.text);

      // Navigator.push empuja una nueva ruta (pantalla) sobre la pila de navegación del usuario.
      // Retorna un Future porque esperamos que la pantalla destino haga un 'pop' y devuelva un String.
      final result = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => TicketSummaryScreen(
            name: name,
            email: email,
            age: age,
            ticketType: _selectedTicket,
          ),
        ),
      );

      // Si se devolvió un código (no es nulo) y el widget sigue montado en el árbol (mounted)
      if (result != null && mounted) {
        setState(() {
          _confirmationCode = result; // Guarda el código de confirmación del ticket
        });
        
        // Resetea visualmente el formulario y limpia físicamente los controladores de texto
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _ageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro al Flutter Fest 2026'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Vincula la llave única al Formulario
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              // Campo para el nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                // Callback de validación. Retorna un mensaje de error si no es válido, o null si está bien
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para el email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress, // Muestra el teclado con símbolo '@'
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  // Expresión regular estándar para verificar formato de email
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailRegex.hasMatch(val)) {
                    return 'Introduce un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para la edad
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number, // Muestra teclado numérico
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  final age = int.tryParse(val);
                  if (age == null) {
                    return 'Introduce un número válido';
                  }
                  if (age < 18) {
                    return 'Debes ser mayor de 18 años para registrarte';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Formulario desplegable (Dropdown)
              DropdownButtonFormField<String>(
                value: _selectedTicket,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Entrada',
                  prefixIcon: Icon(Icons.confirmation_number),
                  border: OutlineInputBorder(),
                ),
                items: _tickets.map((t) {
                  return DropdownMenuItem(value: t, child: Text(t));
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedTicket = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Iniciar Registro', style: TextStyle(fontSize: 16)),
              ),
              // Si ya se generó un código de confirmación de ticket, se dibuja esta sección de éxito
              if (_confirmationCode != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.greenAccent, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        '¡Registro Exitoso!\nCódigo de Confirmación: $_confirmationCode',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
