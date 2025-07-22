import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/service_locator.dart';
import '/core/usecases/usecase.dart';
import '/core/entities/session_entity.dart';
import '/features/auth/domain/entities/profile_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/upload_photo_usecase.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/upload_photo_entity.dart';
import '/core/services/logger_service.dart';
import '/core/services/analytics_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UploadPhotoUseCase uploadPhotoUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getProfileUseCase,
    required this.uploadPhotoUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<GetProfileEvent>(_onGetProfile);
    on<UploadPhotoEvent>(_onUploadPhoto);
    on<CheckAuthEvent>(_onCheckAuth);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) {
        sl<LoggerService>().e('Login error:  ${failure.message}', error: failure);
        emit(AuthError(failure.message));
      },
      (loginEntity) {
        sl<SessionEntity>().update(
          id: loginEntity.id,
          name: loginEntity.name,
          email: loginEntity.email,
          photoUrl: loginEntity.photoUrl,
          token: loginEntity.token,
        );
        sl<AnalyticsService>().logEvent('login_success', parameters: {'user_id': loginEntity.id, 'email': loginEntity.email});
        emit(LoginSuccess(loginEntity));
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await registerUseCase(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) {
        sl<LoggerService>().e('Register error:  ${failure.message}', error: failure);
        emit(AuthError(failure.message));
      },
      (registerEntity) {
        sl<SessionEntity>().update(
          id: registerEntity.id,
          name: registerEntity.name,
          email: registerEntity.email,
          photoUrl: registerEntity.photoUrl,
          token: registerEntity.token,
        );
        sl<AnalyticsService>().logEvent('register_success', parameters: {'user_id': registerEntity.id, 'email': registerEntity.email});
        emit(RegisterSuccess(registerEntity));
      },
    );
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await getProfileUseCase(NoParams());

    result.fold(
      (failure) {
        sl<LoggerService>().e('GetProfile error:  ${failure.message}', error: failure);
        emit(AuthError(failure.message));
      },
      (profileEntity) => emit(ProfileLoaded(profileEntity)),
    );
  }

  Future<void> _onUploadPhoto(UploadPhotoEvent event, Emitter<AuthState> emit) async {
    emit(const PhotoUploading());

    final result = await uploadPhotoUseCase(
      UploadPhotoParams(photoPath: event.photoPath),
    );

    result.fold(
      (failure) {
        sl<LoggerService>().e('UploadPhoto error:  ${failure.message}', error: failure);
        emit(AuthError(failure.message));
      },
      (uploadEntity) {
        sl<SessionEntity>().update(
          id: uploadEntity.id,
          name: uploadEntity.name,
          email: uploadEntity.email,
          photoUrl: uploadEntity.photoUrl,
          token: sl<SessionEntity>().token!,
        );
        emit(PhotoUploaded(uploadEntity));
      },
    );
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await sl<SessionEntity>().loadFromStorage();

    if (!sl<SessionEntity>().isAuthenticated) {
      sl<LoggerService>().w('Token bulunamadı');
      emit(const AuthError('Token bulunamadı'));
      return;
    }

    final result = await getProfileUseCase(NoParams());

    result.fold(
      (failure) {
        sl<SessionEntity>().clear();
        emit(const AuthError('Token geçersiz, lütfen tekrar giriş yapın'));
      },
      (profileEntity) {
        sl<SessionEntity>().update(
          id: profileEntity.id,
          name: profileEntity.name,
          email: profileEntity.email,
          photoUrl: profileEntity.photoUrl,
          token: profileEntity.token,
        );
        emit(AuthAuthenticated(profileEntity));
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    sl<SessionEntity>().clear();
    emit(AuthInitial());
  }
}
