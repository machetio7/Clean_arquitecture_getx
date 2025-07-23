import 'package:get/get.dart';
import 'package:paisa_example/core/utils/routes/app_routes_name.dart';
import 'package:paisa_example/core/utils/shared_preferences.dart';
import 'package:paisa_example/feature/pokemon/domain/entities/pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/use_cases/capture_pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/use_cases/get_captured_pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/use_cases/search_pokemon.dart';

class PokemonController extends GetxController {
  final SearchPokemonUseCase searchPokemon;
  final CapturePokemonUseCase capturePokemon;
  final GetCapturedPokemonUseCase getCapturedPokemon;

  PokemonController({
    required this.searchPokemon,
    required this.capturePokemon,
    required this.getCapturedPokemon,
  });

  var isLoading = false.obs;
  var searchResult = Rxn<Pokemon>();
  var capturedPokemons = <Pokemon>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCapturedPokemons();
  }

  Future<void> fetchCapturedPokemons() async {
    isLoading.value = true;
    final result = await getCapturedPokemon();
    result.fold(
      (failure) =>
          errorMessage.value = 'Error al obtener los Pokémon capturados',
      (pokemons) => capturedPokemons.value = pokemons,
    );
    isLoading.value = false;
  }

  Future<void> searchById(int id) async {
    isLoading.value = true;
    final result = await searchPokemon(id);
    result.fold(
      (failure) {
        errorMessage.value = 'No se encontró el Pokémon';
        searchResult.value = null;
      },
      (pokemon) {
        searchResult.value = pokemon;
        errorMessage.value = '';
      },
    );
    print(searchResult.value?.id);
    isLoading.value = false;
  }

  Future<void> captureCurrentPokemon() async {
    if (searchResult.value == null) return;

    isLoading.value = true;
    final result = await capturePokemon(searchResult.value!);
    result.fold(
      (failure) => errorMessage.value = 'Error al capturar el Pokémon',
      (success) {
        if (success) {
          fetchCapturedPokemons();
          errorMessage.value = '';
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> logout() async {
    await PreferencesUtil.clearAllPreferences();
    Get.offAllNamed(AppRouteNames.login);
  }
}
