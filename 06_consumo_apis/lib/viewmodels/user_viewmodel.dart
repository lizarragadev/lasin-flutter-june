import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

/// =============================================================================
/// ARQUITECTURA MVVM - VIEWMODEL (MODO INTRODUCTORIO)
/// 
/// El ViewModel es el corazón del patrón de diseño MVVM:
/// 1. **Estado Centralizado**: Almacena variables que definen cómo se debe pintar la UI
///    (por ejemplo, si estamos cargando, si hay un error, o si estamos sin conexión).
/// 2. **Desacoplamiento**: La vista no sabe cómo se obtienen los datos de la red o cómo se 
///    guardan localmente; sólo le pide al ViewModel que cargue los datos y dibuja lo que este le provee.
/// 3. **Reactividad con ChangeNotifier**: Cuando las variables cambian, ejecutamos 
///    [notifyListeners()] para reconstruir automáticamente los widgets suscritos.
/// =============================================================================
class UserViewModel extends ChangeNotifier {
  // Instancia de la clase que gestiona las peticiones de red
  final ApiService _apiService = ApiService();

  // Clave de almacenamiento local para guardar y recuperar la caché en SharedPreferences
  static const String _cacheKey = 'cached_users_key';

  // --- VARIABLES DE ESTADO PRIVADAS ---
  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isOffline = false; // Indica si los datos mostrados son de la caché local debido a desconexión

  // --- GETTERS PÚBLICOS (ENCAPSULAMIENTO) ---
  // Exponemos las variables mediante getters para impedir su modificación directa desde la UI
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isOffline => _isOffline;

  /// Método principal asíncrono para cargar los usuarios de la API 
  /// o recuperar la caché local si no hay acceso a internet.
  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    
    // Notifica de inmediato a la UI para que renderice un indicador de carga (loader)
    notifyListeners();

    try {
      // 1. Intentamos obtener los datos frescos de la API
      final fetchedUsers = await _apiService.fetchUsers();
      _users = fetchedUsers;
      _isOffline = false; // Estamos online con datos en tiempo real

      // 2. Guardamos los nuevos datos exitosamente obtenidos en la caché local
      await _saveUsersToCache(fetchedUsers);
    } catch (e) {
      // 3. Si falla la red, activamos la bandera offline e intentamos cargar datos locales
      _isOffline = true;
      final cachedUsers = await _loadUsersFromCache();

      if (cachedUsers.isNotEmpty) {
        _users = cachedUsers;
        _errorMessage = null; // No mostramos error crítico porque pudimos restaurar caché
      } else {
        // Si no hay caché disponible localmente tampoco, reportamos el error completo
        _errorMessage = 'No se pudo conectar al servidor y no existen datos locales guardados.\n\nDetalle: $e';
        _users = [];
      }
    } finally {
      _isLoading = false;
      // Notifica a los widgets consumidores que el estado ha cambiado (éxito, caché o error)
      notifyListeners();
    }
  }

  /// Guarda la lista de usuarios serializada en formato JSON string dentro de SharedPreferences.
  Future<void> _saveUsersToCache(List<User> usersList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Convierte cada objeto User a Map<String, dynamic> y luego a String codificado
      final jsonList = usersList.map((u) => u.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      
      await prefs.setString(_cacheKey, jsonString);
    } catch (e) {
      // Los errores de escritura de caché local no deben bloquear al usuario si el flujo API funcionó
      debugPrint('Error al escribir caché: $e');
    }
  }

  /// Lee e interpreta la cadena JSON almacenada para reconstruir la lista de usuarios.
  Future<List<User>> _loadUsersFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_cacheKey);
      
      if (jsonString != null && jsonString.isNotEmpty) {
        // Decodifica el JSON de vuelta a una lista de mapas
        final List<dynamic> decodedList = jsonDecode(jsonString);
        // Convierte cada mapa individual en una instancia de User
        return decodedList.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error al leer caché: $e');
    }
    return []; // Retorna lista vacía si falla la lectura o no existían datos
  }
}
