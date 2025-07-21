part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const RegisterEvent({required this.email, required this.password, required this.name});
}

class GetProfileEvent extends AuthEvent {
  const GetProfileEvent();
}

class UploadPhotoEvent extends AuthEvent {
  final String photoPath;

  const UploadPhotoEvent({required this.photoPath});
}

class CheckAuthEvent extends AuthEvent {
  const CheckAuthEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
