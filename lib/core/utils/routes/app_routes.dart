import 'package:get/get.dart';
import 'package:paisa_example/core/utils/routes/app_routes_name.dart';
import 'package:paisa_example/feature/login/presentation/bindings/login_binding.dart';
import 'package:paisa_example/feature/login/presentation/screen/login_screen.dart';
import 'package:paisa_example/feature/pokemon/presentation/screens/pokemon_screen.dart';
import 'package:paisa_example/feature/splash/presentation/bindings/splash_binding.dart';
import 'package:paisa_example/feature/splash/presentation/screen/splash_screen.dart';


class AppRoutes {

  static String get initial => AppRouteNames.splash;

  static final routes = [
    GetPage(
      name: AppRouteNames.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.cupertino, 
    ),
    GetPage(
      name: AppRouteNames.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRouteNames.pokemon,
      page: () => PokemonPage(),
      transition: Transition.cupertino,
    ),
  ];
}