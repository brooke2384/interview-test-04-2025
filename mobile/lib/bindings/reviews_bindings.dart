import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/reviews_controller.dart';

class ReviewsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewsController());
  }
}
