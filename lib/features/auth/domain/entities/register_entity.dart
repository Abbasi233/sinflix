import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String id;
  final String message;

  const RegisterEntity({
    required this.id,
    required this.message,
  });

  @override
  List<Object?> get props => [id, message];
}
