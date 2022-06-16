part of 'so_bloc.dart';

abstract class SoEvent extends Equatable {
  const SoEvent();

  @override
  List<Object> get props => [];
}

class CariSoEvent extends SoEvent {
  final int id;
  const CariSoEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CompleteJobEvent extends SoEvent {
  final Timbang timbang;
  const CompleteJobEvent(this.timbang);
}

class GetSessionEvent extends SoEvent {}

class ResetSoEvent extends SoEvent {}

class UpdateTimbangEvent extends SoEvent {
  final Timbang newTimbang;
  const UpdateTimbangEvent(this.newTimbang);
}
