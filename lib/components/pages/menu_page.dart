import 'package:aplikasi_timbang/components/pages/cari_so_page.dart';
import 'package:aplikasi_timbang/components/pages/riwayat_timbang.dart';
import 'package:aplikasi_timbang/components/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Halo,"),
            const Text(
              "Irfan",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
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
                        text: "Cari SO"),
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
                              builder: (context) => const RiwayatTimbangPage(),
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
      ),
    );
  }
}
