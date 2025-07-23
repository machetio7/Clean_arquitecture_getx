import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_example/di.dart';
import 'package:paisa_example/feature/pokemon/presentation/controllers/pokemon_controller.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sl<PokemonController>());

    return ElevatedButton.icon(
      onPressed: controller.captureCurrentPokemon,
      icon: const Icon(Icons.catching_pokemon),
      label: const Text('Capturar'),
    );
  }
}