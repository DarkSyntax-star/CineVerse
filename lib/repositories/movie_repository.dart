import '../models/movie.dart';
import '../services/api_service.dart';
import '../core/constants/api_endpoints.dart';

class MovieRepository {
  final ApiService _api;

  MovieRepository() : _api = ApiService() {
    _api.init();
  }

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _api.get(ApiEndpoints.movies);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getFeatured() async {
    try {
      final response = await _api.get(ApiEndpoints.featured);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getTrending() async {
    try {
      final response = await _api.get(ApiEndpoints.trending);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getTopRated() async {
    try {
      final response = await _api.get(ApiEndpoints.topRated);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getUpcoming() async {
    try {
      final response = await _api.get(ApiEndpoints.upcoming);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Movie> getMovie(int id) async {
    try {
      final response = await _api.get('${ApiEndpoints.movies}/$id');
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      }
      throw Exception('Movie not found');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> search(String query) async {
    try {
      final response = await _api.get(ApiEndpoints.search, query: {'q': query});
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}