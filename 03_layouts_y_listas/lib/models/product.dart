/// Clase Modelo [Product] que representa la estructura de datos de un producto.
/// 
/// TEORÍA SOBRE MODELOS EN DART/FLUTTER:
/// En el desarrollo con Flutter, un "Modelo" es una clase que encapsula y define la estructura
/// de los datos de negocio de la aplicación. Su función principal es actuar como un plano (blueprint)
/// estructurado para convertir información desestructurada (como respuestas JSON de un servidor HTTP o registros de base de datos)
/// en objetos fuertemente tipados con los que el compilador de Dart pueda trabajar de forma segura.
/// 
/// Beneficios del modelado de datos:
/// 1. **Seguridad de Tipos (Type Safety)**: Evita errores en tiempo de ejecución al garantizar que, por ejemplo,
///    el precio sea siempre un número decimal ([double]) y no una cadena de texto.
/// 2. **Autocompletado**: Facilita el trabajo del desarrollador en el IDE ofreciendo sugerencias de atributos válidos.
/// 3. **Mantenimiento**: Si la estructura de un producto cambia, solo se modifica este archivo y el compilador señalará
///    dónde corregir en el resto del proyecto.
class Product {
  // Propiedades inmutables. El uso de 'final' indica que una vez que el valor
  // es asignado a través del constructor, este no puede volver a cambiar (inmutabilidad).
  // La inmutabilidad es una práctica muy recomendada en Flutter para facilitar el control de flujos de estado,
  // evitar efectos secundarios y optimizar la recreación del árbol de widgets.
  
  /// Identificador único del producto en el sistema o base de datos.
  final String id;
  
  /// Nombre comercial descriptivo del producto.
  final String name;
  
  /// Descripción detallada de las características principales del producto.
  final String description;
  
  /// Precio unitario expresado en formato decimal.
  final double price;
  
  /// URL de red de la imagen que ilustra visualmente el producto.
  final String imageUrl;
  
  /// Categoría a la que pertenece el producto para fines de filtrado (ej. Audio, Accesorios).
  final String category;
  
  /// Calificación promedio de satisfacción del producto dada por los usuarios (rango típico de 0 a 5).
  final double rating;

  /// Constructor constante para la clase [Product].
  /// 
  /// TEORÍA DE CONSTRUCTORES Y PARÁMETROS NOMBRADOS:
  /// - **Constructor Constante (`const`)**: Permite instanciar objetos inmutables en tiempo de compilación.
  ///   Si creamos múltiples instancias con los mismos valores estáticos usando `const`, Dart las compartirá
  ///   en una sola dirección de memoria, ahorrando recursos de procesamiento de la CPU.
  /// - **Parámetros Nombrados (delimitados por llaves `{}`)**: Obligan a que al instanciar el objeto,
  ///   se deba especificar explícitamente el nombre de la propiedad (ej. `Product(id: '1', name: '...')`).
  ///   Esto mejora significativamente la legibilidad del código frente a los parámetros posicionales.
  /// - **Palabra clave `required`**: Indica que el compilador impedirá la construcción del objeto
  ///   si no se suministra dicho parámetro obligatorio, reforzando el sistema de Null Safety de Dart.
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });
}
