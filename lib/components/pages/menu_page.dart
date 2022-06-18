import 'package:aplikasi_timbang/components/pages/cari_so_page.dart';
import 'package:aplikasi_timbang/components/pages/login_page.dart';
import 'package:aplikasi_timbang/components/pages/profile_page.dart';
import 'package:aplikasi_timbang/components/pages/riwayat_timbang.dart';
import 'package:aplikasi_timbang/components/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is! LoggedInState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoggedInState) {
            return Padding(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ));
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Halo,"),
                              Text(
                                state.userEntity.fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 24),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MenuButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CariSOPage(),
                                  ),
                                );
                              },
                              text: "Cari PO"),
                          const SizedBox(
                            height: 56,
                          ),
                          MenuButton(
                              icon: const Icon(
                                Icons.list,
                                color: Colors.white,
                              ),
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RiwayatTimbangPage(),
                                  ),
                                );
                              },
                              text: "Riwayat Timbang")
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
