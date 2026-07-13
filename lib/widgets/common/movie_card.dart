import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../models/movie.dart';
import '../../core/constants/tmdb_constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/home/movie/${movie.id}'),
      child: Hero(
        tag: 'movie_${movie.id}',
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: '${TmdbConstants.imageBaseUrl}${movie.posterPath}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (_, __) => Container(color: Colors.grey[300]),
                        errorWidget: (_, __, ___) => Container(color: Colors.grey[300]),
                      )
                    : Container(color: Colors.grey[300]),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(movie.voteAverage.toStringAsFixed(1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}