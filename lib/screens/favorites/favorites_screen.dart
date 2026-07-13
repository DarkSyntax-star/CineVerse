
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/movie_provider.dart';
import '../../widgets/common/movie_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, just show a placeholder
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(
        child: Text('Your favorites will appear here'),
      ),
    );
  }
}
