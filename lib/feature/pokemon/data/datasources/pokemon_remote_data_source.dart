import 'package:paisa_example/core/network/api_endpoints.dart';
import 'package:paisa_example/feature/pokemon/data/models/pokemon_model.dart';
import 'package:dio/dio.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemon(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<PokemonModel> getPokemon(int id) async {
    final resp = await dio.get(ApiEndpoints.getPokemon(id));
    return PokemonModel.fromJson(resp.data);
  }
}
