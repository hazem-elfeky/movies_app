class AppLinks {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static const String movies = "$baseUrl/movies";

  static String movieDetails(int movieId) => "$baseUrl/movies/$movieId";

  static String movieActors(int movieId) => "$movies/$movieId/actors";

  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String user = "$baseUrl/user";
  static const String logout = "$baseUrl/logout";

  static const String genres = "$baseUrl/genres";

  static String toggleFavorite(int movieId) => "$movies/toggle_movie/$movieId";
  static String isFavorite(int movieId) => "$movies/$movieId/is_favorite";
  static const String favorites = "$movies/favorites";
}
