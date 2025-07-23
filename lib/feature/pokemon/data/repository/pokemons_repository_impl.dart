import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:paisa_example/feature/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:paisa_example/feature/pokemon/domain/entities/pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/repository/pokemon_repository.dart';

class PokemonsRepositoryImpl implements PokemonRepository {
  final PokemonLocalDataSource pokemonLocalDataSource;
  final PokemonRemoteDataSource pokemonRemoteDataSource;

  PokemonsRepositoryImpl({
    required this.pokemonLocalDataSource,
    required this.pokemonRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> capturePokemon(Pokemon pokemon) async {
    try {
      final bool resp = await pokemonLocalDataSource.capturePokemon(pokemon);
      return Right(resp);
    } on LocalFailure {
      return Left(LocalFailure('Error'));
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getCapturedPokemon() async {
    try {
      final List<Pokemon> resp = await pokemonLocalDataSource
          .getCapturedPokemonsList();
      return Right(resp);
    } on LocalFailure {
      return Left(LocalFailure('error'));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(int id) async {
    try {
      final Pokemon resp = await pokemonRemoteDataSource.getPokemon(id);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure('error'));
    }
  }
}
