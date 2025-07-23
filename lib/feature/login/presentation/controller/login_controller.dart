import 'package:get/get.dart';
import 'package:paisa_example/core/utils/routes/app_routes_name.dart';
import 'package:paisa_example/core/utils/shared_preferences.dart';
import 'package:paisa_example/feature/login/domain/entitites/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/use_cases/login_use_case.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController({required this.loginUseCase});

  var isLoading = false.obs;
  var user = Rxn<User>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkIfLoggedIn();
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final result = await loginUseCase(email, password);
    await result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (userData) async {
        user.value = userData;
        await PreferencesUtil.set('token', userData.token);

        // Navega a la pantalla protegida
        Get.offNamed(AppRouteNames.pokemon);
      },
    );

    isLoading.value = false;
  }

  Future<bool> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  //   Get.offAllNamed(AppRouteNames.login);
  // }
}
