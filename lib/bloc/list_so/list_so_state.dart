part of 'list_so_bloc.dart';

abstract class ListSoState extends Equatable {
  const ListSoState();

  @override
  List<Object> get props => [];
}

class ListSoLoading extends ListSoState {}

class ListSoInitial extends ListSoState {}

class ListSoError extends ListSoState {
  final String message;
  const ListSoError({
    required this.message,
  }) : super();

  @override
  List<Object> get props => [message];
}

class ListSoLoaded extends ListSoState {
  final List<Timbang> timbang;
  final List<Timbang> completedTimbang;

  const ListSoLoaded(this.timbang, this.completedTimbang) : super();

  @override
  List<Object> get props => [timbang, completedTimbang];
}
