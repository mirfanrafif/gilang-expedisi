part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class LoggedInState extends UserState {
  final UserEntity userEntity;
  final String token;

  const LoggedInState({
    required this.userEntity,
    required this.token,
  });

  @override
  List<Object> get props => [userEntity, token];
}
