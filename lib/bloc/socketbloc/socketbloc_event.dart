part of 'socketbloc_bloc.dart';

abstract class SocketblocEvent extends Equatable {
  const SocketblocEvent();

  @override
  List<Object> get props => [];
}

class InitSocketEvent extends SocketblocEvent {}
