part of 'so_bloc.dart';

abstract class SoEvent extends Equatable {
  const SoEvent();

  @override
  List<Object> get props => [];
}

class SelectSOEvent extends SoEvent {
  final Timbang timbang;
  const SelectSOEvent({required this.timbang});

  @override
  List<Object> get props => [];
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
