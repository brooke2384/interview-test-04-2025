import 'package:get/get.dart';
import 'package:kmbal_movies_app/models/user.dart';

class AuthController extends GetxController {
  String? _token;
  final Rx<User?> _user = Rx<User?>(null);

  /// Reactive auth state
  final RxBool isAuthenticated = false.obs;

  /// Getter for user
  User? get user => _user.value;

  /// Set and persist token
  void setToken(String token) {
    _token = token;
    isAuthenticated.value = true;
  }

  /// Set the current user
  void setUser(User userData) {
    _user.value = userData;
  }

  /// Get current token or throw
  String requireToken() {
    if (_token?.isNotEmpty != true) {
      throw Exception("Missing or invalid auth token.");
    }
    return _token!;
  }

  /// Full reset of auth state
  void clearAuth() {
    _token = null;
    _user.value = null;
    isAuthenticated.value = false;
  }

  /// Safe getter for token (nullable)
  String? get token => _token;

  /// Check if user exists (and is loaded)
  bool get hasUser => _user.value != null;
}
