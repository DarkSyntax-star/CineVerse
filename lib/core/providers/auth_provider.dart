import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<User?> {
  final AuthRepository _authRepo;
  AuthNotifier(this._authRepo) : super(null) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final user = await _authRepo.getCurrentUser();
    if (user != null) state = user;
  }

  Future<bool> login(String email, String password) async {
    final user = await _authRepo.login(email, password);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _authRepo.logout();
    state = null;
  }

  Future<bool> register(String email, String username, String password, String fullName) async {
    final user = await _authRepo.register(email, username, password, fullName);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }
}