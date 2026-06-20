import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// stateLess = sin estado, no cambia nada, es solo para mostrar algo
// stateFul = con estado, puede cambiar algo, es para mostrar algo que cambia
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi Perfil Profesional",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.teal,
      ),
      home: ProfileScreen(
        isDarkMode: _isDarkMode,
        onThemeToggle: _toggleTheme,
      )
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          )
        ]
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 65,
                backgroundColor: Colors.teal,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("https://images.unsplash.com/photo-1654110455429-cf322b40a906?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
                )
              ),
              const SizedBox(height: 16),
              const Text(
                "Josué Martínez",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2
                )
              ),
              const SizedBox(height: 8),
              Text(
                "Desarrollador Flutter",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal.shade400,
                  fontWeight: FontWeight.w500,
                )
              ),
              const SizedBox(height: 16),
              const Text(
                "Desarrollador de aplicaciones móviles con experiencia en Flutter. Apasionado por crear interfaces de usuario atractivas y funcionales. Siempre buscando aprender nuevas tecnologías y mejorar mis habilidades.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                )
              ),
              const SizedBox(height: 24),
              const Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.code, color: Colors.teal),
                          SizedBox(height: 4),
                          Text("40+", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Proyectos", style: TextStyle(fontSize: 12))
                        ]
                      ),
                      Column(
                        children: [
                          Icon(Icons.star, color: Colors.teal),
                          SizedBox(height: 4),
                          Text("4.9", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Calificación", style: TextStyle(fontSize: 12))
                        ]
                      ),
                      Column(
                        children: [
                          Icon(Icons.work, color: Colors.teal),
                          SizedBox(height: 4),
                          Text("+5 años", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Experiencia", style: TextStyle(fontSize: 12))
                        ]
                      ),
                    ]
                  )
                )
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.email),
                    label: const Text("Contactar"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    )
                  ),
                  SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text("Descargar CV"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    )
                  )
                ]
              )
            ]
          ) 
        ),
      )
    );
  }
}