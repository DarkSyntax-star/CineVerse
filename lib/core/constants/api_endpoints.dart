
class ApiEndpoints {
  static const String baseUrl = 'http://192.168.56.1:8000/api/v1'; // Android emulator
  // static const String baseUrl = 'http://localhost:8000/api/v1'; // iOS/Chrome
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String movies = '/movies';
  static const String featured = '/movies/featured';
  static const String trending = '/movies/trending';
  static const String topRated = '/movies/top-rated';
  static const String upcoming = '/movies/upcoming';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
}
