part of 'so_bloc.dart';

abstract class SoEvent extends Equatable {
  const SoEvent();

  @override
  List<Object> get props => [];
}

class CariSoEvent extends SoEvent {
  int id;
  String token;
  CariSoEvent({
    required this.id,
    required this.token,
  });

  @override
  List<Object> get props => [id, token];
}
