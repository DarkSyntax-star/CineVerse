
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Text(
                      user.fullName?.substring(0, 1) ?? user.username.substring(0, 1),
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.fullName ?? user.username,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(user.email),
                  const SizedBox(height: 20),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorites'),
                    onTap: () => context.go('/favorites'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => context.go('/settings'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout'),
                    onTap: () async {
                      await ref.read(authStateProvider.notifier).logout();
                      context.go('/auth/login');
                    },
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
