import 'package:get/get.dart';

class AuthController extends GetxController {
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  String requireToken() {
    if (_token == null) {
      throw Exception("Missing auth token.");
    }
    return _token!;
  }

  bool isAuthenticated() {
    return _token != null;
  }
}
