import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;
  final bool isSignedUp;

  const AuthState({
    this.isLoading = false,
    this.error,
    this.isLoggedIn = false,
    this.isSignedUp = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
    bool? isSignedUp,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isSignedUp: isSignedUp ?? this.isSignedUp,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false, isLoggedIn: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false, isSignedUp: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
