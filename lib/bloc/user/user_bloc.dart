import 'package:aplikasi_timbang/data/models/user.dart';
import 'package:aplikasi_timbang/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  var repository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<LoginEvent>(onLogin);
    on<CheckSessionEvent>(onCheckSession);
  }

  onCheckSession(CheckSessionEvent event, Emitter<UserState> emit) {
    var token = repository.getToken();
    if (token != null) {
      var user = repository.getUser();
      emit(LoggedInState(userEntity: user, token: token));
    }
  }

  void onLogin(LoginEvent event, Emitter<UserState> emit) async {
    var response = await repository.login(event.email, event.password);

    if (response.success) {
      var user = UserEntity(
          id: response.data?.user?.id ?? 0,
          fullName: response.data?.user?.fullName ?? '',
          email: response.data?.user?.email ?? '',
          role: response.data?.user?.role ?? '');

      repository.saveUser(user);
      repository.saveToken(response.data?.accessToken ?? '');

      emit(LoggedInState(
        userEntity: user,
        token: response.data?.accessToken ?? '',
      ));
    } else {}
  }
}
