import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String _email = '';
  String _error = '';

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String get email => _email;
  String get error => _error;

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      // Add your actual authentication logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      _isLoggedIn = true;
      _email = email;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _email = '';
    notifyListeners();
  }
}