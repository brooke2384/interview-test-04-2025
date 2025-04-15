import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
