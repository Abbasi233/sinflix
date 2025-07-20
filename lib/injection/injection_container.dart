import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/network/network_info.dart';
import '../core/storage/local_storage_service.dart';
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../features/auth/data/datasources/auth_rest_api/auth_rest_api.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/register_usecase.dart';
import '../features/auth/domain/usecases/get_profile_usecase.dart';
import '../features/auth/domain/usecases/upload_photo_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/theme/data/datasources/theme_local_data_source.dart';
import '../features/theme/data/datasources/theme_local_data_source_impl.dart';
import '../features/theme/data/repositories/theme_repository_impl.dart';
import '../features/theme/domain/repositories/theme_repository.dart';
import '../features/theme/presentation/bloc/theme_cubit.dart';
import '../shared/data/datasources/shared_preferences_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPrefsService = SharedPreferencesService();
  await sharedPrefsService.init();

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      getProfileUseCase: sl(),
      uploadPhotoUseCase: sl(),
    ),
  );

  sl.registerFactory(() => ThemeCubit(repository: sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UploadPhotoUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(authRestApi: sl()),
  );

  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(localStorageService: sl()),
  );

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AuthRestApi(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<LocalStorageService>(() => sharedPrefsService);
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}
