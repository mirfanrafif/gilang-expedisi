part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CheckSessionEvent extends UserEvent {}

class LoginEvent extends UserEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends UserEvent {}
