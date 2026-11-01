import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/auth_repository.dart';

/// AsyncNotifier => Include Loading - Error - Success
class AuthController extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.watch(authRepoProvider);
  }

  Future<bool> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => _authRepository.signInWithGoogle(),
    );
    if (result.hasError) {
      state = AsyncValue.error(result.error!, result.stackTrace!);
      return false;
    } else {
      state = const AsyncValue.data(null);
      return result.value != null;
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() => _authRepository.signOut());
    if (result.hasError) {
      state = AsyncValue.error(result.error!, result.stackTrace!);
    } else {
      state = const AsyncValue.data(null);
    }
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);
