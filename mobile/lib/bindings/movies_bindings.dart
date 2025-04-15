import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/movies_controller.dart';

class MoviesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoviesController());
  }
}
