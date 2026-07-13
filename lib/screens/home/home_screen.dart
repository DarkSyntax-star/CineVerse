import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/movie_provider.dart';
import '../../widgets/common/movie_card.dart';
import '../../widgets/common/loading_shimmer.dart';
import '../../widgets/home/featured_banner.dart';
import '../../widgets/home/movie_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredMoviesProvider);
    final trendingAsync = ref.watch(trendingMoviesProvider);
    final topRatedAsync = ref.watch(topRatedMoviesProvider);
    final upcomingAsync = ref.watch(upcomingMoviesProvider);
    final moviesAsync = ref.watch(movieListProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: featuredAsync.when(
                data: (movies) => FeaturedBanner(movies: movies),
                loading: () => const LoadingShimmer(width: double.infinity, height: 250),
                error: (_, __) => Container(color: Colors.grey),
              ),
              collapseMode: CollapseMode.parallax,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => context.go('/search'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                MovieSection(
                  title: 'Trending Now',
                  movies: trendingAsync.value ?? [],
                  isLoading: trendingAsync.isLoading,
                ),
                MovieSection(
                  title: 'Top Rated',
                  movies: topRatedAsync.value ?? [],
                  isLoading: topRatedAsync.isLoading,
                ),
                MovieSection(
                  title: 'Upcoming',
                  movies: upcomingAsync.value ?? [],
                  isLoading: upcomingAsync.isLoading,
                ),
                MovieSection(
                  title: 'Recommended',
                  movies: moviesAsync.value ?? [],
                  isLoading: moviesAsync.isLoading,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) context.go('/favorites');
          if (index == 2) context.go('/profile');
        },
      ),
    );
  }
}