import 'package:flutter/material.dart';

// Función principal que inicia la aplicación Flutter
void main() {
  runApp(const MainApp());
}

// Widget principal que hereda de StatefulWidget porque controlará el estado del tema (claro/oscuro)
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

// Estado del widget principal
class _MainAppState extends State<MainApp> {
  // Estado local para alternar entre el tema claro u oscuro
  bool _isDarkMode = true;

  // Método encargado de cambiar el estado de la UI
  void _toggleTheme() {
    // setState notifica al framework que el estado interno ha cambiado y fuerza un rediseño (rebuild) de este widget
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Perfil Profesional',
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de depuración (debug banner)
      theme: ThemeData(
        useMaterial3: true, // Habilita los estándares de diseño de Material Design 3
        brightness: _isDarkMode ? Brightness.dark : Brightness.light, // Define el brillo del tema actual
        colorSchemeSeed: Colors.teal, // Define la paleta de colores basada en un color semilla
      ),
      home: ProfileScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme, // Pasa la función como callback a la pantalla del perfil
      ),
    );
  }
}

// Pantalla informativa independiente (StatelessWidget porque no muta internamente, recibe los datos del padre)
class ProfileScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeChanged; // Callback de tipo función sin argumentos ni retorno

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold proporciona la estructura básica visual de Material Design (AppBar, Drawer, SnackBars, etc.)
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
        actions: [
          // Botón en la barra superior que ejecuta la función de cambio de tema del widget padre
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeChanged,
          ),
        ],
      ),
      body: Center(
        // Center centra a su widget hijo horizontal y verticalmente
        child: SingleChildScrollView(
          // SingleChildScrollView permite hacer scroll vertical si el contenido supera el tamaño físico de la pantalla
          padding: const EdgeInsets.all(24.0), // Margen interno uniforme en todos los lados
          child: Column(
            // Column alinea sus widgets hijos uno debajo del otro (verticalmente)
            mainAxisAlignment: MainAxisAlignment.center, // Centra los hijos verticalmente dentro del Column
            children: [
              // Avatar circular con borde
              const CircleAvatar(
                radius: 65,
                backgroundColor: Colors.teal,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=60',
                  ),
                ),
              ),
              const SizedBox(height: 20), // SizedBox proporciona una separación vertical/espaciador
              const Text(
                'Camila Lizárraga',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Desarrolladora Senior Flutter',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Apasionada por crear aplicaciones móviles de alto rendimiento y hermosas experiencias de usuario con una sola base de código.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4, // Interlineado del texto
                ),
              ),
              const SizedBox(height: 30),
              // Tarjeta visual (Card) con sombra integrada
              const Card(
                elevation: 4, // Nivel de sombra y profundidad de la tarjeta
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Row(
                    // Row alinea sus widgets hijos uno al lado del otro (horizontalmente)
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuye el espacio sobrante entre los widgets
                    children: [
                      Column(
                        children: [
                          Icon(Icons.code, color: Colors.teal),
                          SizedBox(height: 4),
                          Text('40+', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Proyectos', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.star, color: Colors.teal),
                          SizedBox(height: 4),
                          Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Calificación', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.work, color: Colors.teal),
                          SizedBox(height: 4),
                          Text('5 años', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Experiencia', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón elevado principal con un icono integrado
                  ElevatedButton.icon(
                    onPressed: () {}, // Acción vacía por ahora
                    icon: const Icon(Icons.email),
                    label: const Text('Contactar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Botón con contorno/borde sin fondo relleno
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Descargar CV'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
