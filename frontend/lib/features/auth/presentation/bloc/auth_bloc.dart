import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/is_loggedin.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetUserUseCase getUserUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getUserUseCase,
    required this.logoutUseCase,
    required this.isLoggedInUseCase,
  }) : super(AuthState.initial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthCheckRequested>(_onCheck);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final res = await loginUseCase(event.email, event.password);

    res.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (data) =>
          emit(AuthState.authenticated(data['message'] ?? 'Login successful')),
    );
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final res = await registerUseCase(event.name, event.email, event.password);

    res.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (data) => emit(
        AuthState.authenticated(data['message'] ?? 'Registration successful'),
      ),
    );
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final res = await logoutUseCase();

    res.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(AuthState.unauthenticated()),
    );
  }

  Future<void> _onCheck(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final res = await isLoggedInUseCase();
    res.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (logged) => emit(
        logged ? AuthState.authenticated() : AuthState.unauthenticated(),
      ),
    );
  }
}
