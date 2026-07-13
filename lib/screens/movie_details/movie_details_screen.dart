import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/providers/movie_provider.dart';
import '../../core/constants/tmdb_constants.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailsProvider(movieId));
    return Scaffold(
      body: movieAsync.when(
        data: (movie) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      movie.backdropPath != null
                          ? CachedNetworkImage(
                              imageUrl: '${TmdbConstants.backdropBaseUrl}${movie.backdropPath}',
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(color: Colors.grey),
                              errorWidget: (_, __, ___) => Container(color: Colors.grey),
                            )
                          : Container(color: Colors.grey),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 20),
                          const SizedBox(width: 4),
                          Text(movie.voteAverage.toStringAsFixed(1)),
                          const SizedBox(width: 16),
                          // Runtime might not be available from TMDB
                          const SizedBox(width: 16),
                          if (movie.releaseDate != null)
                            Text(movie.releaseDate!.split('-')[0]),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Trailer button removed for now
                      const SizedBox(height: 16),
                      Text(
                        movie.overview ?? '',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Error loading movie')),
      ),
    );
  }
}