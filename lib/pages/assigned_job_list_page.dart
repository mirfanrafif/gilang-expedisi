import 'dart:developer';

import 'package:aplikasi_timbang/bloc/list_so/list_so_bloc.dart';
import 'package:aplikasi_timbang/bloc/socketbloc/socketbloc_bloc.dart';
import 'package:aplikasi_timbang/bloc/user/user_bloc.dart';
import 'package:aplikasi_timbang/pages/riwayat_timbang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/so_list.dart';

class AssignedJobListPage extends StatefulWidget {
  const AssignedJobListPage({Key? key}) : super(key: key);

  @override
  State<AssignedJobListPage> createState() => _AssignedJobListPageState();
}

class _AssignedJobListPageState extends State<AssignedJobListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return BlocListener<SocketblocBloc, SocketblocState>(
        listener: (context, state) {
          if (state is SocketBlocLoaded) {
            state.socket.on("assigned-job-${state.user.id.toString()}",
                (data) async {
              log(data.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Terdapat SO baru. Data diperbarui"),
                  behavior: SnackBarBehavior.floating,
                  dismissDirection: DismissDirection.up,
                ),
              );
              context.read<ListSoBloc>().add(const GetSoByUserIdEvent());
            });
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: state is LoggedInState
                  ? Text('Halo, ${state.userEntity.fullName}')
                  : const Text('Halo'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  //bisa diganti dengan foto profil kalo dibutuhkan
                  child: Container(
                    color: const Color.fromARGB(
                      255,
                      70,
                      70,
                      70,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text('Daftar Tugas'),
                  ),
                  Tab(
                    child: Text('Riwayat Timbang'),
                  )
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                SoList(),
                RiwayatSO(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
