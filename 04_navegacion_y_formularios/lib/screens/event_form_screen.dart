import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/registration_model.dart';
import '../routes/app_routes.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  
  String _selectedTicket = 'General';
  final List<String> _tickets = ['General', 'VIP', 'Backstage Access'];
  String? _confirmationCode;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final registration = RegistrationModel(
        name: _nameController.text,
        email: _emailController.text,
        age: int.parse(_ageController.text),
        ticketType: _selectedTicket,
      );

      final result = await Navigator.pushNamed<dynamic>(
        context,
        AppRoutes.summary,
        arguments: registration,
      );

      if (result != null && mounted) {
        setState(() {
          _confirmationCode = result as String;
        });
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
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
              TextFormField(
                controller: _nameController,
                maxLength: 50,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  if (val.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  if (val.trim().length > 50) {
                    return 'El nombre no puede exceder los 50 caracteres';
                  }
                  final nameRegex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
                  if (!nameRegex.hasMatch(val)) {
                    return 'El nombre solo debe contener letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                maxLength: 100,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  if (val.length > 100) {
                    return 'El correo no puede exceder los 100 caracteres';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailRegex.hasMatch(val)) {
                    return 'Introduce un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                maxLength: 3,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  if (val.length > 3) {
                    return 'La edad no es válida';
                  }
                  final age = int.tryParse(val);
                  if (age == null) {
                    return 'Introduce un número entero válido';
                  }
                  if (age < 18) {
                    return 'Debes ser mayor de 18 años para registrarte';
                  }
                  if (age > 100) {
                    return 'Introduce una edad realista (menor a 100)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedTicket,
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
              if (_confirmationCode != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x4D1B5E20),
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
