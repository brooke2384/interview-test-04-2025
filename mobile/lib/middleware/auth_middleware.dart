import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthController _authController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (_authController.isAuthenticated.value) {
      return super.redirect(route);
    }
    return RouteSettings(name: "/login");
  }
}