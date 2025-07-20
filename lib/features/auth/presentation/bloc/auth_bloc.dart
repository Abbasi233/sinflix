import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/usecases/usecase.dart';
import '/core/entities/session_entity.dart';
import '/injection/injection_container.dart';
import '/features/auth/domain/entities/profile_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/upload_photo_usecase.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/upload_photo_entity.dart';

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
      (failure) => emit(AuthError(failure.message)),
      (loginEntity) {
        sl<SessionEntity>().update(
          id: loginEntity.id,
          name: loginEntity.name,
          email: loginEntity.email,
          photoUrl: loginEntity.photoUrl,
          token: loginEntity.token,
        );

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
      (failure) => emit(AuthError(failure.message)),
      (registerEntity) {
        emit(RegisterSuccess(registerEntity));
      },
    );
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await getProfileUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (profileEntity) => emit(ProfileLoaded(profileEntity)),
    );
  }

  Future<void> _onUploadPhoto(UploadPhotoEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await uploadPhotoUseCase(
      UploadPhotoParams(
        photoPath: event.photoPath,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uploadEntity) => emit(PhotoUploaded(uploadEntity)),
    );
  }
}
