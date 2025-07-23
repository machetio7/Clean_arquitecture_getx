class ApiEndpoints {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // Pokémon endpoints
  static String getPokemon(int id) => 'https://pokeapi.co/api/v2/pokemon/$id/';
  static const String allPokemons = '/pokemon';

  // Login or Auth (si tuvieras uno propio)
  static const String login = '/login'; // Ejemplo
}