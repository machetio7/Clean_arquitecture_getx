import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_example/di.dart';
import 'package:paisa_example/feature/pokemon/presentation/controllers/pokemon_controller.dart';

class PokemonSearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  PokemonSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonController = Get.put(sl<PokemonController>());

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Buscar Pokémon por ID',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            final id = int.tryParse(_controller.text);
            if (id != null) {
              pokemonController.searchById(id);
            } else {
              Get.snackbar('Error', 'Ingresa un número válido');
            }
          },
        ),
      ],
    );
  }
}