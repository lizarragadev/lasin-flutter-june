// ignore_for_file: unused_import, unused_field
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

/// =============================================================================
/// ARQUITECTURA MVVM - VIEWMODEL SKELETON
/// 
/// El ViewModel une la capa de datos (Service/Model) con la capa de presentación (View):
/// 1. Declara las variables de estado privadas necesarias:
///    - Lista de usuarios (_users)
///    - Booleano de estado de carga (_isLoading)
///    - String opcional para errores (_errorMessage)
///    - Booleano de bandera offline (_isOffline)
/// 2. Implementa los getters públicos correspondientes para proteger el estado.
/// 3. Diseña el método asíncrono fetchUsers() que consuma el ApiService y guarde
///    en caché si la red funciona, o cargue la caché en caso de fallo de red.
/// 4. Diseña los métodos privados para guardar y cargar caché con SharedPreferences.
/// =============================================================================
class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Clave de almacenamiento local para guardar los usuarios en SharedPreferences
  static const String _cacheKey = 'cached_users_key';

  // TODO: 1. Declarar variables de estado (users, isLoading, errorMessage, isOffline)
  
  // TODO: 2. Implementar getters públicos

  // TODO: 3. Implementar el método principal fetchUsers()
  Future<void> fetchUsers() async {
    // Código aquí
    // Recuerda llamar a notifyListeners() cuando el estado cambie (carga, datos, error)
  }

  // TODO: 4. Implementar método para guardar caché local
  // Future<void> _saveUsersToCache(List<User> usersList) async { ... }

  // TODO: 5. Implementar método para leer caché local
  // Future<List<User>> _loadUsersFromCache() async { ... }
}
