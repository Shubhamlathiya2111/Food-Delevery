import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> signIn(String email, String password) async {
    // Implement sign in logic
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    // Implement sign out logic
    _isAuthenticated = false;
    notifyListeners();
  }
} 