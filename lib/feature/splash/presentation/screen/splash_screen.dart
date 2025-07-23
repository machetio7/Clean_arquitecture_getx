import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_example/core/utils/extensions.dart';
import 'package:paisa_example/feature/splash/presentation/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF21CBF3)], // Fondo degradado azul
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Obx(() {
            // Mientras carga, mostrar logo y spinner
            if (controller.isLoading.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo con animación
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Image.network(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png', // Pikachu oficial
                      width: 150,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red, size: 100);
                      },
                    ),
                  ),
                  30.ph,
                  const Text(
                    'Pokémon Trainer',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  20.ph,
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              );
            } else {
              // No debería verse nada porque ya redirigió
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}