import 'package:dartz/dartz.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/pokemon/domain/entities/pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/repository/pokemon_repository.dart';

class GetCapturedPokemonUseCase {
  final PokemonRepository repository;

  GetCapturedPokemonUseCase({required this.repository});

  Future<Either<Failure, List<Pokemon>>> call() {
    return repository.getCapturedPokemon();
  }
}
