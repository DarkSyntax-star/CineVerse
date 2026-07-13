import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/movie_provider.dart';
import '../../widgets/common/movie_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _debounce = Debounce(milliseconds: 500);

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (query) {
            _debounce.run(() {
              ref.read(searchResultsProvider.notifier).search(query);
            });
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search movies, actors, genres...',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.white54),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              ref.read(searchResultsProvider.notifier).clear();
            },
          ),
        ],
      ),
      body: searchResults.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(child: Text('No movies found'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) => MovieCard(movie: movies[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Error searching')),
      ),
    );
  }
}

class Debounce {
  final int milliseconds;
  Timer? _timer;
  Debounce({required this.milliseconds});
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
  void dispose() => _timer?.cancel();
}