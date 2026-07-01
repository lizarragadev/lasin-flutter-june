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
      await _saveUsersToCache(fetchedUsers);
    } catch(e) {
      _isOffline = true;
      final cachedUsers = await _loadUsersFromCache();

      if(cachedUsers.isNotEmpty) {
        _users = cachedUsers;
        _errorMessage = null;
      } else {
        _errorMessage = "No se pudo conectar al servidor y no existen datos locales guardados.";
        _users = [];
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveUsersToCache(List<User> userList) async {
    try  {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = userList.map((u) => u.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_cacheKey, jsonString);
    } catch(e) {
      debugPrint("Error al escribir caché.");
    }
  }

  Future<List<User>>_loadUsersFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_cacheKey);
      if(jsonString != null  && jsonString.isNotEmpty) {
        final List<dynamic> decodeList = jsonDecode(jsonString);
        return decodeList.map((json) => User.fromJson(json)).toList();
      }
    } catch(e) {
      debugPrint("Error al leer la caché.");
    }
    return [];
  }

}
