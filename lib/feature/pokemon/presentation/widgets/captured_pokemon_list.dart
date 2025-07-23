import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_example/di.dart';
import 'package:paisa_example/feature/pokemon/presentation/controllers/pokemon_controller.dart';

class CapturedPokemonList extends StatelessWidget {
  const CapturedPokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sl<PokemonController>());

    return Obx(() {
      if (controller.capturedPokemons.isEmpty) {
        return const Center(child: Text('No hay Pokémon capturados.'));
      }
      return ListView.builder(
        itemCount: controller.capturedPokemons.length,
        itemBuilder: (context, index) {
          final pokemon = controller.capturedPokemons[index];
          return ListTile(
            leading: Image.network(pokemon.image),
            title: Text(pokemon.name),
            subtitle: Text('ID: ${pokemon.id}'),
          );
        },
      );
    });
  }
}