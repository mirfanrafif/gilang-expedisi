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

class SoLoaded extends SoState {
  final Timbang timbang;

  const SoLoaded(this.timbang) : super();

  @override
  List<Object> get props => [timbang];
}

class SoNotFound extends SoState {
  final int id;
  final String message;
  const SoNotFound({
    required this.id,
    required this.message,
  }) : super();

  @override
  List<Object> get props => [id, message];
}

class SoComplete extends SoState {
  SoComplete() : super();
}
