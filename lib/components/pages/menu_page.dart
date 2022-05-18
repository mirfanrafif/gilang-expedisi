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
                    getMenuButton(
                        context,
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        "Cari SO",
                        () {}),
                    const SizedBox(
                      height: 56,
                    ),
                    getMenuButton(
                        context,
                        const Icon(
                          Icons.list,
                          color: Colors.white,
                        ),
                        "Riwayat Timbang",
                        () {}),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget getMenuButton(
      BuildContext context, Icon icon, String text, Function() onClick) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: Container(
            color: Theme.of(context).primaryColor,
            width: 80,
            height: 80,
            child: IconButton(
              icon: icon,
              onPressed: onClick,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(text),
      ],
    );
  }
}
