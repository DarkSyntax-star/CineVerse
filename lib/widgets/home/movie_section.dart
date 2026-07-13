import 'package:flutter/material.dart';
import '../../models/movie.dart';
import '../common/movie_card.dart';
import '../common/loading_shimmer.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final bool isLoading;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: LoadingShimmer(width: 120, height: 200),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 140,
                        child: MovieCard(movie: movies[index]),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}