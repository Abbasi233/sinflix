import 'package:get_it/get_it.dart';
import 'package:retrofit/error_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sinflix/core/entities/session_entity.dart';

import '/core/network/dio_config.dart';
import '/core/network/error_logger.dart';
import '/core/navigation/app_router.dart';
import '/core/storage/local_storage_service.dart';
import '/features/auth/data/datasources/auth_remote_data_source.dart';
import '/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '/features/auth/data/datasources/auth_rest_api/auth_rest_api.dart';
import '/features/auth/data/repositories/auth_repository_impl.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/usecases/login_usecase.dart';
import '/features/auth/domain/usecases/register_usecase.dart';
import '/features/auth/domain/usecases/get_profile_usecase.dart';
import '/features/auth/domain/usecases/upload_photo_usecase.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/theme/data/datasources/theme_local_data_source.dart';
import '/features/theme/data/datasources/theme_local_data_source_impl.dart';
import '/features/theme/data/repositories/theme_repository_impl.dart';
import '/features/theme/domain/repositories/theme_repository.dart';
import '/features/theme/presentation/bloc/theme_cubit.dart';
import '/core/storage/secure_storage_service.dart';
import '/features/dashboard/data/datasource/movie_rest_api/movie_rest_api.dart';
import '/features/dashboard/data/datasource/movie_remote_data_source.dart';
import '/features/dashboard/data/datasource/movie_remote_data_source_impl.dart';
import '/features/dashboard/data/repositories/movie_repository_impl.dart';
import '/features/dashboard/domain/repositories/movie_repository.dart';
import '/features/dashboard/presentation/bloc/movie_bloc.dart';
import '/features/dashboard/domain/usecases/get_movies_usecase.dart';
import '/features/dashboard/domain/usecases/get_favorite_movies_usecase.dart';
import '/features/dashboard/domain/usecases/favorite_movie_usecase.dart';
import '/features/dashboard/data/datasource/tmdb_remote_data_source.dart';
import '/features/dashboard/data/datasource/tmdb_remote_data_source_impl.dart';
import '/features/dashboard/domain/usecases/get_tmdb_poster_url_usecase.dart';
import 'package:sinflix/core/services/logger_service.dart';
import 'package:sinflix/core/services/analytics_service.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final secureStorageService = SecureStorageService();
  await secureStorageService.init();

  sl.registerLazySingleton(() => AppRouter());

  sl.registerLazySingleton(() => SessionEntity());

  sl.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      getProfileUseCase: sl(),
      uploadPhotoUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => ThemeCubit(repository: sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UploadPhotoUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(authRestApi: sl(), sessionEntity: sl()),
  );

  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(localStorageService: sl()),
  );

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(api: sl(), sessionEntity: sl()),
  );

  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => MovieBloc(movieRepository: sl()),
  );

  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoriteMoviesUseCase(sl()));
  sl.registerLazySingleton(() => FavoriteMovieUseCase(sl()));

  sl.registerLazySingleton(() => DioConfig.instance);
  sl.registerLazySingleton<ParseErrorLogger>(() => ErrorLogger());
  sl.registerLazySingleton(() => AuthRestApi(sl(), errorLogger: sl()));
  sl.registerLazySingleton(() => MovieRestApi(sl(), errorLogger: sl()));

  sl.registerLazySingleton<LocalStorageService>(() => secureStorageService);
  sl.registerLazySingleton<TmdbRemoteDataSource>(
    () => TmdbRemoteDataSourceImpl(apiKey: dotenv.env['TMDB_API_KEY'] ?? ''),
  );
  sl.registerLazySingleton(() => GetTmdbPosterUrlUseCase(sl()));
  sl.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsServiceImpl());
}
