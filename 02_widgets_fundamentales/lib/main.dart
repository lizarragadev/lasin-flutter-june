import 'package:flutter/material.dart';

/// Punto de entrada de la aplicación.
/// La función [main] es la función especial de Dart donde comienza la ejecución del programa.
/// En Flutter, llamamos a [runApp] dentro de [main] para inicializar y montar la raíz del árbol de widgets
/// en la pantalla del dispositivo. [runApp] infla el widget que recibe como parámetro y lo convierte
/// en el nodo raíz de la jerarquía visual de renderizado (Widget Tree).
void main() {
  // Inicializa y arranca la aplicación pintando el widget MainApp en la pantalla.
  // Usamos 'const' aquí porque MainApp tiene un constructor constante, lo que permite a Flutter
  // optimizar la memoria reutilizando la misma instancia en lugar de recrearla.
  runApp(const MainApp());
}

/// [MainApp] es el punto de inicio visual y de configuración general de la aplicación.
/// Hereda de [StatefulWidget] porque esta clase necesita retener y modificar datos que mutan en el tiempo:
/// en este caso, la preferencia de tema visual (Tema Claro o Tema Oscuro).
/// 
/// TEORÍA SOBRE STATEFULWIDGET:
/// Un [StatefulWidget] se divide en dos clases distintas por cuestiones de rendimiento del motor de Flutter:
/// 1. La clase que hereda de [StatefulWidget] (esta clase), la cual es inmutable (todas sus propiedades finales).
///    Flutter recrea estas instancias de widgets muy frecuentemente cuando hay cambios.
/// 2. La clase que hereda de [State] (definida abajo), la cual es mutable y persiste a lo largo del tiempo
///    manteniendo los datos en memoria y la ubicación en el árbol de elementos (Element Tree).
class MainApp extends StatefulWidget {
  // El parámetro 'super.key' permite pasar la clave única de este widget a la clase base [StatefulWidget].
  // Las llaves (Keys) ayudan a Flutter a identificar de forma única qué widgets han cambiado, se han movido
  // o se han eliminado en el árbol cuando el estado se actualiza.
  const MainApp({super.key});

  /// [createState] es el primer método del ciclo de vida de un [StatefulWidget].
  /// Flutter lo invoca automáticamente para asociar un elemento del árbol con el estado mutable.
  /// Retorna una nueva instancia de [_MainAppState], la cual manejará el ciclo de vida y renderizado de este nodo.
  @override
  State<MainApp> createState() => _MainAppState();
}

/// Clase que representa el estado persistente y la lógica visual para [MainApp].
/// El guion bajo (_) en [_MainAppState] define que esta clase es privada para este archivo.
/// 
/// TEORÍA SOBRE EL CICLO DE VIDA Y SETSTATE:
/// En Flutter, la interfaz de usuario es una función directa del estado: UI = f(State).
/// Cuando una variable dentro de esta clase cambia, el framework no detecta automáticamente la mutación
/// a menos que usemos el método [setState].
class _MainAppState extends State<MainApp> {
  // Variable de estado local. Almacena un valor booleano: true para modo oscuro y false para modo claro.
  // Esta variable representa el "Estado del Tema" (Theme State).
  bool _isDarkMode = true;

  /// Método encargado de alternar la preferencia del tema.
  /// Actúa como un manejador de eventos (Event Handler) que será invocado por interacción del usuario.
  void _toggleTheme() {
    // [setState] es un método heredado de la clase base [State].
    // Su propósito es registrar un callback donde mutamos nuestras variables de estado y, al mismo tiempo,
    // notificar al motor de Flutter que este widget está "sucio" (dirty).
    // Esto programa un fotograma (frame) para reconstruir este widget y su descendencia llamando a [build].
    // NUNCA modifiques el estado fuera de [setState] si deseas que la pantalla se actualice.
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  /// El método [build] es el núcleo de cualquier Widget.
  /// Flutter lo invoca automáticamente para describir cómo se ve la interfaz de usuario en base al estado actual.
  /// 
  /// Qué es el [BuildContext]:
  /// El parámetro 'context' es una instancia de [BuildContext]. Esencialmente, es el mango o manija que vincula
  /// a este widget con su posición exacta dentro del Árbol de Elementos (Element Tree). Permite realizar búsquedas
  /// hacia arriba en el árbol para obtener temas, tamaños de pantalla, localizaciones, etc. (InheritedWidgets).
  @override
  Widget build(BuildContext context) {
    // [MaterialApp] es el widget de conveniencia que envuelve toda nuestra app.
    // Configura el motor de Material Design, incluyendo el navegador (Navigator) para las rutas,
    // el sistema de temas globales y los servicios de accesibilidad y traducción del sistema operativo.
    return MaterialApp(
      title: 'Mi Perfil Profesional',
      // Oculta la pequeña banda roja "DEBUG" en la esquina superior derecha durante la fase de desarrollo.
      debugShowCheckedModeBanner: false, 
      
      // Configuración de temas visuales globales
      theme: ThemeData(
        // Habilita las especificaciones de diseño y componentes modernos de Material Design 3.
        useMaterial3: true, 
        
        // Define la paleta cromática de la aplicación adaptándose dinámicamente según el estado '_isDarkMode'.
        brightness: _isDarkMode ? Brightness.dark : Brightness.light, 
        
        // Genera de forma inteligente todo el esquema cromático armonioso (colores primarios, secundarios,
        // fondos, alertas, etc.) partiendo de un color de origen común (Teal / Verde azulado).
        colorSchemeSeed: Colors.teal, 
      ),
      
      // Pantalla inicial (home) cargada al arrancar la aplicación.
      // Le pasamos el estado de tema actual y la función callback para que pueda notificar los clics.
      home: ProfileScreen(
        isDarkMode: _isDarkMode,
        // Pasamos la referencia a la función '_toggleTheme' como parámetro (Callback).
        // En Dart, las funciones son objetos de primera clase, lo que nos permite pasarlas como argumentos.
        onThemeChanged: _toggleTheme, 
      ),
    );
  }
}

/// Pantalla que presenta el perfil del desarrollador.
/// Hereda de [StatelessWidget] porque esta pantalla en sí misma es pasiva e inmutable;
/// no retiene ningún estado interno que cambie por sí misma.
/// Toda la información dinámica que necesita (el tema oscuro actual y el callback para cambiarlo)
/// le es suministrada por su widget padre ([MainApp]) a través de su constructor.
/// 
/// TEORÍA SOBRE STATELESSWIDGET:
/// Los [StatelessWidget] son increíblemente eficientes. Al no tener estado persistente asociado,
/// Flutter puede destruirlos y volver a crearlos al instante con un costo computacional mínimo.
/// Si el padre se reconstruye y los parámetros pasados al constructor cambian, Flutter actualiza
/// el elemento subyacente para que apunte al nuevo widget y llama de nuevo a su método [build].
class ProfileScreen extends StatelessWidget {
  // Propiedad inmutable para almacenar la preferencia del tema oscuro del widget padre.
  final bool isDarkMode;
  
  // Propiedad que almacena el Callback (la función de tipo VoidCallback: una función sin retorno ni parámetros).
  // Se ejecutará cuando el usuario interactúe con el botón de cambio de tema.
  final VoidCallback onThemeChanged; 

  // Constructor constante. El uso de constructores constantes es una buena práctica crítica en Flutter,
  // ya que permite almacenar el árbol de widgets en memoria estática de solo lectura y omitir reconstrucciones
  // (rebuilds) innecesarias si los parámetros no varían, optimizando el recolector de basura (garbage collector).
  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // [Scaffold] es el widget fundamental que actúa como lienzo de diseño bajo la especificación Material Design.
    // Proporciona la infraestructura visual estructural de primer nivel: coloca automáticamente la barra de navegación
    // superior (AppBar), la barra inferior (BottomNavigationBar), el cuerpo del contenido (body), cajones flotantes (Drawer)
    // o botones de acción flotantes (FloatingActionButton), asegurando el espaciado adecuado.
    return Scaffold(
      // [AppBar] es la cabecera visual de la pantalla.
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        // Centra el título en plataformas móviles (comportamiento por defecto en iOS, forzado en Android).
        centerTitle: true, 
        // Lista de widgets de acción que se alinean horizontalmente al final de la barra superior.
        actions: [
          // [IconButton] es un botón táctil sin bordes que envuelve a un icono visual.
          IconButton(
            // Operador ternario de Dart que selecciona dinámicamente la apariencia del icono.
            // Si está oscuro, muestra el sol (light_mode). Si está claro, muestra la luna (dark_mode).
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            // Ejecuta el callback proporcionado por el widget padre para cambiar el tema de la aplicación.
            onPressed: onThemeChanged,
          ),
        ],
      ),
      
      // El cuerpo del Scaffold
      body: Center(
        // [Center] es un widget de maquetación que toma el tamaño máximo que le da su padre
        // y posiciona a su hijo exactamente en el medio horizontal y vertical del espacio disponible.
        child: SingleChildScrollView(
          // [SingleChildScrollView] es una caja con scroll automático para un único hijo.
          // EXPLICACIÓN TÉCNICA:
          // Si el tamaño de los elementos hijos excede el tamaño físico de la pantalla,
          // Flutter lanza un error visual de desbordamiento (Overflow Error), indicado por líneas diagonales amarillas y negras.
          // Al envolver el contenido en un SingleChildScrollView, hacemos que la pantalla sea desplazable
          // verticalmente de forma dinámica, adaptándose a pantallas pequeñas o a cuando se despliega el teclado virtual.
          padding: const EdgeInsets.all(24.0), // Aplica un margen interno (padding) de 24 píxeles lógicos en los 4 bordes.
          
          child: Column(
            // [Column] es un widget de maquetación lineal (Flex) que organiza a su lista de widgets hijos
            // de forma vertical (uno debajo de otro).
            // EJE PRINCIPAL (Main Axis) de una columna: Es el eje vertical.
            // EJE SECUNDARIO (Cross Axis) de una columna: Es el eje horizontal.
            
            // Centra la lista de hijos verticalmente dentro de la columna, distribuyéndolos de forma concentrada.
            mainAxisAlignment: MainAxisAlignment.center, 
            
            children: [
              // ----------------- AVATAR CON BORDE DOBLE -----------------
              // [CircleAvatar] exterior que sirve para simular el borde de color del avatar principal.
              const CircleAvatar(
                radius: 65, // Radio total de 65 píxeles lógicos (diámetro de 130).
                backgroundColor: Colors.teal, // Color del borde.
                
                // [CircleAvatar] interior que contiene la imagen real del perfil.
                child: CircleAvatar(
                  radius: 60, // Radio de 60 píxeles, dejando 5 píxeles de espacio para el borde del padre.
                  // [NetworkImage] carga la imagen de forma asíncrona desde internet utilizando su URL.
                  // Se encarga de descargar la imagen en hilos de background, decodificarla y guardarla en caché.
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=60',
                  ),
                ),
              ),
              
              // [SizedBox] es un espaciador de dimensiones fijas.
              // A diferencia de [Container], [SizedBox] es extremadamente eficiente porque no realiza operaciones
              // complejas de dibujado o decoración de bordes; solo altera las restricciones de tamaño durante el layout.
              const SizedBox(height: 20), 
              
              // ----------------- NOMBRE DEL USUARIO -----------------
              const Text(
                'Camila Lizárraga',
                style: TextStyle(
                  fontSize: 28, // Tamaño de fuente grande para destacar la identidad.
                  fontWeight: FontWeight.bold, // Negrita extrema para jerarquización tipográfica.
                  letterSpacing: 0.5, // Espaciado fino entre caracteres para legibilidad.
                ),
              ),
              
              const SizedBox(height: 8),
              
              // ----------------- CARGO / TÍTULO PROFESIONAL -----------------
              Text(
                'Desarrolladora Senior Flutter',
                style: TextStyle(
                  fontSize: 18,
                  // Recupera el color Teal y selecciona la variante 400 del catálogo para dar contraste cromático.
                  color: Colors.teal.shade400, 
                  fontWeight: FontWeight.w500, // Grosor medio de fuente (Semibold).
                ),
              ),
              
              const SizedBox(height: 16),
              
              // ----------------- DESCRIPCIÓN PERFIL PROFESIONAL -----------------
              const Text(
                'Apasionada por crear aplicaciones móviles de alto rendimiento y hermosas experiencias de usuario con una sola base de código.',
                textAlign: TextAlign.center, // Centra el flujo de texto multilínea.
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4, // Interlineado tipográfico (Line Height) para mejorar la lectura cómoda.
                ),
              ),
              
              const SizedBox(height: 30),
              
              // ----------------- TARJETA DE ESTADÍSTICAS (CARD) -----------------
              // [Card] proporciona un aspecto visual tipo panel o tarjeta basada en elevación e iluminación.
              const Card(
                // [elevation] define la intensidad de la sombra proyectada. A mayor elevación,
                // mayor es el nivel del eje Z del widget y, por lo tanto, la sombra será más difusa y pronunciada.
                elevation: 4, 
                
                // [Padding] añade espaciado interno en los bordes de la tarjeta para evitar que el contenido toque las esquinas.
                child: Padding(
                  // Usamos 'symmetric' para definir márgenes simétricos independientes: vertical y horizontal.
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  
                  child: Row(
                    // [Row] organiza a sus hijos de forma horizontal (uno al lado del otro).
                    // EJE PRINCIPAL (Main Axis) de una fila: Es el eje horizontal.
                    // EJE SECUNDARIO (Cross Axis) de una fila: Es el eje vertical.
                    
                    // Distribuye de manera equitativa el espacio horizontal sobrante entre los elementos hijos
                    // y los extremos de la fila, de modo que queden perfectamente alineados y balanceados.
                    mainAxisAlignment: MainAxisAlignment.spaceAround, 
                    
                    children: [
                      // Sub-columna de Proyectos
                      Column(
                        children: [
                          Icon(Icons.code, color: Colors.teal),
                          SizedBox(height: 4),
                          Text('40+', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Proyectos', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      
                      // Sub-columna de Calificación
                      Column(
                        children: [
                          Icon(Icons.star, color: Colors.teal),
                          SizedBox(height: 4),
                          Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Calificación', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      
                      // Sub-columna de Experiencia
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
              
              // ----------------- BOTONES DE ACCIÓN PRINCIPALES -----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centra el grupo de botones horizontalmente.
                children: [
                  // [ElevatedButton.icon] es un botón pre-estilizado con elevación de Material 3
                  // que incluye un constructor especial para posicionar ordenadamente un Icono y un Texto lado a lado.
                  ElevatedButton.icon(
                    onPressed: () {}, // Acción del botón. Se deja vacío en esta etapa del curso.
                    icon: const Icon(Icons.email),
                    label: const Text('Contactar'),
                    // [styleFrom] configura de forma rápida propiedades estéticas específicas del botón.
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  
                  const SizedBox(width: 16), // Espacio intermedio horizontal entre los dos botones.
                  
                  // [OutlinedButton.icon] es un botón sin fondo de color sólido, delimitado por un borde fino
                  // (Outline). Es ideal para acciones secundarias, asegurando un contraste visual balanceado.
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
