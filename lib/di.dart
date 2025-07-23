import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:paisa_example/core/utils/shared_preferences.dart';
import 'package:paisa_example/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:paisa_example/feature/login/data/repository/login_repository_impl.dart';
import 'package:paisa_example/feature/login/domain/repository/login_repository.dart';
import 'package:paisa_example/feature/login/domain/use_cases/login_use_case.dart';
import 'package:paisa_example/feature/login/presentation/controller/login_controller.dart';
import 'package:paisa_example/feature/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:paisa_example/feature/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:paisa_example/feature/pokemon/data/repository/pokemons_repository_impl.dart';
import 'package:paisa_example/feature/pokemon/domain/repository/pokemon_repository.dart';
import 'package:paisa_example/feature/pokemon/domain/use_cases/capture_pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/use_cases/get_captured_pokemon.dart';
import 'package:paisa_example/feature/pokemon/domain/use_cases/search_pokemon.dart';
import 'package:paisa_example/feature/pokemon/presentation/controllers/pokemon_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_URL'] ?? '',
        headers: {
          'x-api-key': dotenv.env['API_KEY'] ?? '',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PreferencesUtil.get(
            'token',
          );
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  });

  // DataSources
  sl.registerLazySingleton<PokemonLocalDataSource>(
    () => HivePokemonLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonsRepositoryImpl(
      pokemonLocalDataSource: sl(),
      pokemonRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(loginRemoteDataSourceImpl: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => CapturePokemonUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCapturedPokemonUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchPokemonUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));

  // Controllers
  sl.registerFactory(
    () => PokemonController(
      searchPokemon: sl(),
      capturePokemon: sl(),
      getCapturedPokemon: sl(),
    ),
  );

  sl.registerFactory(() => LoginController(loginUseCase: sl()));
}
