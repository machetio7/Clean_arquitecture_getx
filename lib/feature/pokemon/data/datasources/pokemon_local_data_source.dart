import 'package:flutter/widgets.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/pokemon/data/models/pokemon_model.dart';
import 'package:paisa_example/feature/pokemon/domain/entities/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PokemonLocalDataSource {
  Future<bool> capturePokemon(Pokemon pokemon);
  Future<List<PokemonModel>> getCapturedPokemonsList();
}

class HivePokemonLocalDataSourceImpl implements PokemonLocalDataSource {

  @override
  Future<bool> capturePokemon(Pokemon pokemon) async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');
      box.put(pokemon.id, PokemonModel.fromEntity(pokemon).toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure('error');
    }
  }

  @override
  Future<List<PokemonModel>> getCapturedPokemonsList() async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');
      return box.values.map((toElement) => PokemonModel.fromJson(toElement)).toList();
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure('Error');
    }
  }
}
