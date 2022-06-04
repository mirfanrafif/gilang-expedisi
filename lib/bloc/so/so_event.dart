part of 'so_bloc.dart';

abstract class SoEvent extends Equatable {
  const SoEvent();

  @override
  List<Object> get props => [];
}

class CariSoEvent extends SoEvent {
  int id;
  CariSoEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
