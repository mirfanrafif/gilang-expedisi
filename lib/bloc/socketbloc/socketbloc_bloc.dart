import 'dart:developer';
import 'dart:io';

import 'package:aplikasi_timbang/data/models/user.dart';
import 'package:aplikasi_timbang/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'socketbloc_event.dart';
part 'socketbloc_state.dart';

class SocketblocBloc extends Bloc<SocketblocEvent, SocketblocState> {
  var userRepository = UserRepository();

  SocketblocBloc() : super(SocketblocInitial()) {
    on<InitSocketEvent>(
        (InitSocketEvent event, Emitter<SocketblocState> emit) async {
      var user = userRepository.getUser();

      try {
        var socketClient = io(
            "https://api.gilangexpedisi.com",
            OptionBuilder()
                .setTransports(['websocket'])
                .enableReconnection()
                .build());

        socketClient.onConnectError((data) {
          if (data is WebSocketException) {
          } else if (data is SocketException) {
          } else {}
        });
        socketClient.onConnect((data) {
          log("socket connected");
        });
        emit(SocketBlocLoaded(socketClient, user));
      } on Exception catch (e) {
        log(e.toString());
      }
    });
  }
}
