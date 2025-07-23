import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_example/core/utils/extensions.dart';
import 'package:paisa_example/core/utils/routes/app_routes_name.dart';
import 'package:paisa_example/di.dart';
import 'package:paisa_example/feature/pokemon/presentation/controllers/pokemon_controller.dart';
import 'package:paisa_example/feature/pokemon/presentation/widgets/%20pokemon_search_bar.dart';
import 'package:paisa_example/feature/pokemon/presentation/widgets/capture_button.dart';
import 'package:paisa_example/feature/pokemon/presentation/widgets/captured_pokemon_list.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🚨 REGISTRA en GetX para que funcione Obx
    final controller = Get.put(sl<PokemonController>());

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()=>{controller.logout()}, child: Icon(Icons.logout),),
      appBar: AppBar(title: const Text('Pokémon Trainer')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PokemonSearchBar(), // <-- asegúrate que internamente usa controller.searchById
              20.ph,
              if (controller.searchResult.value != null)
                Column(
                  children: [
                    Text(
                      controller.searchResult.value!.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CaptureButton(),
                  ],
                ),
              30.ph,
              const Text('Pokémon capturados', style: TextStyle(fontSize: 18)),
              10.ph,
              Expanded(child: CapturedPokemonList()),
            ],
          ),
        );
      }),
    );
  }
}
