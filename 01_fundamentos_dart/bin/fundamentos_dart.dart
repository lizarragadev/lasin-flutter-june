void main() async {
  print('=== EJERCICIO 1: Variables y Tipos de Datos ===');
  // TODO: Declarar una variable de tipo String (nombre), una de tipo int (edad) y una de tipo double (estatura).
  // TODO: Declarar una variable 'final' y una 'const' y explicar la diferencia.
  
  print('\n=== EJERCICIO 2: Null Safety ===');
  // TODO: Declarar una variable de tipo String que acepte nulos (String?).
  // TODO: Usar el operador de coalescencia nula (??) para asignar un valor por defecto si es nula.
  // TODO: Usar la llamada segura (?.) y la aserción no nula (!).

  print('\n=== EJERCICIO 3: Funciones ===');
  // TODO: Crear una función básica que reciba nombre y edad y devuelva un saludo.
  // TODO: Crear una función de flecha (arrow function) que calcule el doble de un número.

  print('\n=== EJERCICIO 4: Clases y Objetos ===');
  // TODO: Crear una instancia de la clase Persona definida abajo.
  // TODO: Imprimir los datos del objeto usando su método.

  print('\n=== EJERCICIO 5: Colecciones (Listas y Mapas) ===');
  // TODO: Crear una lista de números.
  // TODO: Filtrar los números pares usando .where() y convertirlos de nuevo a lista.
  // TODO: Crear un mapa (clave-valor) que represente un producto (nombre, precio, stock).

  print('\n=== EJERCICIO 6: Programación Asíncrona (Futures, async/await) ===');
  print('Solicitando datos del servidor...');
  // TODO: Llamar a la función asíncrona obtenerDatosServidor() y esperar su resultado.
  print('Fin del programa principal.');
}

// TODO: Definir una clase llamada Persona
// Debe tener atributos: nombre (String), edad (int).
// Debe tener un constructor con argumentos nombrados (named parameters) y requeridos.
// Opcional: Agregar un método para presentarse.

// TODO: Crear una función asíncrona llamada obtenerDatosServidor
// Debe retornar un Future<String> y demorar 2 segundos usando Future.delayed.
