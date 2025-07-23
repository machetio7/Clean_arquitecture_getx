import 'package:dartz/dartz.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/pokemon/domain/entities/pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/repository/pokemon_repository.dart';

class SearchPokemonUseCase {
  final PokemonRepository repository;

  SearchPokemonUseCase({required this.repository});

  Future<Either<Failure, Pokemon>> call(int id) {
    return repository.getPokemon(id);
  }
}
