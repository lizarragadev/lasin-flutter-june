// ignore_for_file: unused_import, unused_field
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  static const String _cacheKey = 'cached_users_key';

  // TODO: 1. Declarar variables de estado (users, isLoading, errorMessage, isOffline)
  
  // TODO: 2. Implementar getters públicos

  // TODO: 3. Implementar el método principal fetchUsers() para obtener datos y guardar en caché local
  Future<void> fetchUsers() async {
    // Recuerda llamar a notifyListeners()
  }

  // TODO: 4. Implementar método para guardar caché local
  // Future<void> _saveUsersToCache(List<User> usersList) async { ... }

  // TODO: 5. Implementar método para leer caché local
  // Future<List<User>> _loadUsersFromCache() async { ... }
}
