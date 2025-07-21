part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginEntity loginEntity;

  const LoginSuccess(this.loginEntity);
}

class RegisterSuccess extends AuthState {
  final RegisterEntity registerEntity;

  const RegisterSuccess(this.registerEntity);
}

class ProfileLoaded extends AuthState {
  final ProfileEntity profileEntity;

  const ProfileLoaded(this.profileEntity);
}

class PhotoUploading extends AuthState {
  const PhotoUploading();
}

class PhotoUploaded extends AuthState {
  final UploadPhotoEntity uploadEntity;

  const PhotoUploaded(this.uploadEntity);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

class AuthAuthenticated extends AuthState {
  final ProfileEntity profileEntity;

  const AuthAuthenticated(this.profileEntity);
}
