part of 'so_bloc.dart';

abstract class SoState extends Equatable {
  const SoState();

  @override
  List<Object> get props => [];
}

class SoInitial extends SoState {
  const SoInitial() : super();
}

class SoLoading extends SoState {
  const SoLoading() : super();
}

class SoSelected extends SoState {
  final Timbang timbang;
  const SoSelected({required this.timbang});

  @override
  List<Object> get props => [timbang];
}

class CompletingJob extends SoState {}

class SoComplete extends SoState {
  const SoComplete() : super();
}
