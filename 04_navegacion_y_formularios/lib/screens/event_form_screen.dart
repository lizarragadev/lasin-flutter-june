import 'package:flutter/material.dart';
import '../models/registration_model.dart';
import '../routes/app_routes.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  // TEORÍA SOBRE GLOBALKEY Y FORMSTATE:
  // [GlobalKey] es una clave única en toda la aplicación. Al tiparla como GlobalKey<FormState>,
  // nos permite obtener una referencia directa al estado del widget [Form] desde fuera de su árbol local.
  // Es indispensable para llamar a métodos como validate(), save() o reset() en eventos de botón.
  final _formKey = GlobalKey<FormState>();

  // TEORÍA SOBRE TEXTEDITINGCONTROLLERS:
  // Un [TextEditingController] es un objeto controlador que se asocia a un campo de texto (TextField/TextFormField).
  // Se encarga de:
  // 1. Escuchar y almacenar los cambios del texto introducido en tiempo real.
  // 2. Permitir leer el valor actual mediante '.text'.
  // 3. Permitir modificar el texto por código (ej. limpiar el campo).
  // NOTA DE DESEMPEÑO: Los controladores consumen recursos y listeners del sistema operativo.
  // Es obligatorio liberarlos en el método [dispose] para prevenir fugas de memoria (memory leaks).
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  
  String _selectedTicket = 'General';
  final List<String> _tickets = ['General', 'VIP', 'Backstage Access'];
  String? _confirmationCode;

  @override
  void dispose() {
    // Liberación de recursos del sistema al destruir el estado de la pantalla.
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  /// Procesa la lógica de validación, empaquetado de datos y navegación.
  void _submitForm() async {
    // TEORÍA DE VALIDACIÓN DE FORMULARIOS:
    // El método 'validate()' dispara automáticamente la función 'validator' de cada uno
    // de los TextFormFields que están anidados dentro de nuestro widget Form.
    // Retorna true únicamente si todos los validators retornan null (es decir, ningún error).
    if (_formKey.currentState!.validate()) {
      // Empaquetamos la información recolectada del texto crudo de los controladores.
      final registration = RegistrationModel(
        name: _nameController.text,
        email: _emailController.text,
        age: int.parse(_ageController.text),
        ticketType: _selectedTicket,
      );

      // TEORÍA DE NAVEGACIÓN Y RETORNO DE DATOS:
      // - [Navigator.pushNamed]: Cambia de pantalla cargando la ruta nombrada.
      // - [arguments]: Parámetro que permite enviar cualquier tipo de objeto como argumento a la ruta de destino.
      // - [await]: Esperamos de forma asíncrona a que la pantalla destino se cierre. Si la pantalla destino
      //   retorna un valor mediante 'Navigator.pop(context, valor)', este método lo capturará aquí.
      final result = await Navigator.pushNamed<dynamic>(
        context,
        AppRoutes.summary,
        arguments: registration,
      );

      // Si el usuario confirmó el ticket, recibimos el código de confirmación.
      if (result != null && mounted) {
        setState(() {
          _confirmationCode = result as String;
        });
        
        // Limpiamos los estados internos del Form y de los controladores de texto.
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
          // Asociamos la clave única para controlar este formulario
          key: _formKey,
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
              
              // TEORÍA SOBRE TEXTFORMFIELD Y VALIDATOR:
              // A diferencia de TextField, [TextFormField] se integra de manera nativa con el widget [Form].
              // - [validator]: Callback de tipo String? Function(String?). Si retorna un mensaje,
              //   Flutter lo dibuja automáticamente abajo del campo en color rojo y bloquea el submit del Form.
              //   Si retorna null, indica que el valor introducido es correcto.
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  // Validación de presencia
                  if (val == null || val.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  // Validación de longitud mínima y máxima para evitar desbordamiento visual
                  if (val.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  if (val.trim().length > 50) {
                    return 'El nombre no puede exceder los 50 caracteres';
                  }
                  // Validación de tipo de dato mediante expresión regular: solo letras y espacios
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
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  // Validación de presencia
                  if (val == null || val.isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  // Validación de longitud máxima permitida en base de datos estándar
                  if (val.length > 100) {
                    return 'El correo no puede exceder los 100 caracteres';
                  }
                  // Validación de tipo de dato y estructura mediante expresión regular (Regex)
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
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  // Validación de presencia
                  if (val == null || val.isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  // Validación de longitud (máximo 3 dígitos)
                  if (val.length > 3) {
                    return 'La edad no es válida';
                  }
                  // Validación de tipo de dato numérico entero mediante tryParse
                  final age = int.tryParse(val);
                  if (age == null) {
                    return 'Introduce un número entero válido';
                  }
                  // Validación de rango lógico de edad para el registro
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
                    color: const Color(0x4D1B5E20), // Color verde oscuro traslúcido.
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
