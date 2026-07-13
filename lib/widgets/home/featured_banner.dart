import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/movie.dart';
import '../../core/constants/tmdb_constants.dart';
import 'package:go_router/go_router.dart';

class FeaturedBanner extends StatelessWidget {
  final List<Movie> movies;
  const FeaturedBanner({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return Container(color: Colors.grey);
    final movie = movies[0];
    return GestureDetector(
      onTap: () => context.go('/home/movie/${movie.id}'),
      child: Stack(
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
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    if (movie.releaseDate != null)
                      Text(
                        movie.releaseDate!.split('-')[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}