// ignore_for_file: unused_import, unused_field
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  static const String _cacheKey = 'cached_users_key';

  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isOffline = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isOffline => _isOffline;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final fetchedUsers = await _apiService.fetchUsers();
      _users = fetchedUsers;
      _isOffline = false;
      //guardar en cache
    } catch(e) {
      _errorMessage = e.toString();
      // Cuando no haya conexión a internet
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // TODO: 4. Implementar método para guardar caché local
  // Future<void> _saveUsersToCache(List<User> usersList) async { ... }

  // TODO: 5. Implementar método para leer caché local
  // Future<List<User>> _loadUsersFromCache() async { ... }
}
