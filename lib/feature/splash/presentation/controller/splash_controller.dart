import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paisa_example/core/utils/routes/app_routes_name.dart';

class SplashController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    // Simula carga inicial
    await Future.delayed(const Duration(seconds: 2)); 

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // ✅ Redirigir a Pokémon si hay token
      Get.offNamed(AppRouteNames.pokemon);
    } else {
      // 🚪 Redirigir a Login si no hay token
      Get.offNamed(AppRouteNames.login);
    }

    isLoading.value = false;
  }
}