part of 'so_bloc.dart';

abstract class SoState extends Equatable {
  const SoState();

  @override
  List<Object> get props => [];
}

class SoInitial extends SoState {}

class SoLoading extends SoState {}

class SoLoaded extends SoState {
  final Timbang timbang;

  const SoLoaded(this.timbang);
}

class SoNotFound extends SoState {
  final int id;

  const SoNotFound({required this.id});
}
