part of 'socketbloc_bloc.dart';

abstract class SocketblocState extends Equatable {
  const SocketblocState();

  @override
  List<Object> get props => [];
}

class SocketblocInitial extends SocketblocState {}

class SocketBlocLoaded extends SocketblocState {
  final Socket socket;
  final UserEntity user;

  const SocketBlocLoaded(this.socket, this.user);

  @override
  List<Object> get props => [socket];
}
