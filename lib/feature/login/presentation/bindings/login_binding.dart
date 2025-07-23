import 'package:get/get.dart';
import 'package:paisa_example/di.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => sl<LoginController>());
  }
}