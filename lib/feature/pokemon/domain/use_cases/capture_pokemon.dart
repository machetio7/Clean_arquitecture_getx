import 'package:dartz/dartz.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/pokemon/domain/entities/pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/repository/pokemon_repository.dart';

class CapturePokemonUseCase {
  final PokemonRepository repository;

  CapturePokemonUseCase({required this.repository});

  Future<Either<Failure, bool>> call(Pokemon pokemon) {
    return repository.capturePokemon(pokemon);
  }
}
