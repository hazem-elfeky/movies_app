import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_movies/core/navigation/app_navigator.dart';
import 'package:my_movies/core/network/api_client.dart';
import 'package:my_movies/core/network/network_info.dart';
import 'package:my_movies/core/services/app_prefs.dart';
import 'package:my_movies/features/actor/domain/usecases/get_movie_actor_usecase.dart';
import 'package:my_movies/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_movies/features/auth/domain/usecases/is_loggedin.dart';
import 'package:my_movies/features/auth/domain/usecases/signup_usecase.dart';
import 'package:my_movies/features/favorite/data/datasources/favorite_remote_data_source.dart';
import 'package:my_movies/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:my_movies/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:my_movies/features/favorite/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:my_movies/features/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_bloc.dart';
import 'package:my_movies/features/genre/domain/usecases/get_genre_usecase.dart';
import 'package:my_movies/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:my_movies/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:my_movies/features/movie/domain/repositories/movie_repository.dart';
import 'package:my_movies/features/movie/domain/usecases/get_movies_usecase.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_details_block/movie_get_details_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:my_movies/features/movie/domain/usecases/get_movie_details_usecase.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/get_user_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/genre/data/datasources/genre_remote_data_source.dart';
import '../../features/genre/data/repositories/genre_repository_impl.dart';
import '../../features/genre/domain/repositories/genre_repository.dart';
import '../../features/genre/presentation/bloc/genre_bloc.dart';

import '../../features/actor/data/datasources/actor_remote_data_source.dart';
import '../../features/actor/data/repositories/actor_repository_impl.dart';
import '../../features/actor/domain/repositories/actor_repository.dart';
import '../../features/actor/presentation/bloc/actor_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => Connectivity());

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt(), getIt()));
  getIt.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(getIt()),
  );
  getIt.registerLazySingleton<AppNavigator>(() => AppNavigator());

  // Auth feature
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: getIt<AuthRemoteDataSource>(),
      prefs: getIt<SharedPreferencesService>(),
    ),
  );

  // Usecases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetUserUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => IsLoggedInUseCase(getIt<AuthRepository>()));

  // Bloc
  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      getUserUseCase: getIt<GetUserUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      isLoggedInUseCase: getIt<IsLoggedInUseCase>(),
    ),
  );

  // Genre feature
  getIt.registerLazySingleton<GenreRemoteDataSource>(
    () => GenreRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<GenreRepository>(
    () => GenreRepositoryImpl(
      getIt<GenreRemoteDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.registerLazySingleton(() => GetGenresUseCase(getIt<GenreRepository>()));

  getIt.registerFactory(() => GenreBloc(getIt<GetGenresUseCase>()));

  //movies
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      getIt<MovieRemoteDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.registerLazySingleton(() => GetMoviesUseCase(getIt<MovieRepository>()));
  // Register GetMovieDetailsUseCase
  getIt.registerLazySingleton(
    () => GetMovieDetailsUseCase(getIt<MovieRepository>()),
  );

  getIt.registerFactory(() => MovieBloc(getIt<GetMoviesUseCase>()));
  // Register MovieGetDetailsBloc
  getIt.registerFactory(
    () => MovieGetDetailsBloc(getIt<GetMovieDetailsUseCase>()),
  );

  // NEW REGISTRATIONS
  getIt.registerLazySingleton<ActorRemoteDataSource>(
    () => ActorRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<ActorRepository>(
    () => ActorRepositoryImpl(
      remoteDataSource: getIt<ActorRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetMovieActorsUseCase(getIt<ActorRepository>()),
  );

  getIt.registerFactory(
    () => ActorBloc(getMovieActorsUseCase: getIt<GetMovieActorsUseCase>()),
  );

  // Favorite
  getIt.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(remote: getIt(), networkInfo: getIt()),
  );
  getIt.registerLazySingleton(() => GetFavoritesUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleFavoriteUseCase(getIt()));
  getIt.registerFactory(
    () => FavoriteBloc(
      getFavoritesUseCase: getIt(),
      toggleFavoriteUseCase: getIt(),
    ),
  );
}
