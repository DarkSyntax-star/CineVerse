
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/movie.dart';
import '../../repositories/movie_repository.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository();
});

final movieListProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getMovies();
});

final featuredMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getFeatured();
});

final trendingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getTrending();
});

final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getTopRated();
});

final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getUpcoming();
});

final movieDetailsProvider = FutureProvider.family<Movie, int>((ref, id) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getMovie(id);
});

final searchResultsProvider = StateNotifierProvider<SearchNotifier, AsyncValue<List<Movie>>>((ref) {
  return SearchNotifier(ref.watch(movieRepositoryProvider));
});

class SearchNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  final MovieRepository _repo;
  SearchNotifier(this._repo) : super(const AsyncValue.data([]));

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final results = await _repo.search(query);
      state = AsyncValue.data(results);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}
