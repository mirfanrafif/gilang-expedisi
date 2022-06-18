import 'package:flutter/material.dart';

import '../../data/models/timbang.dart';

class RiwayatTimbangItem extends StatelessWidget {
  final Timbang timbang;
  const RiwayatTimbangItem({Key? key, required this.timbang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PO #" + timbang.soId.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text("Status: Selesai"),
                Text(timbang.createdAt.toLocal().toString())
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(getTargetTimbang()),
                Text("400 Ekor"),
              ],
            )
          ],
        ),
      ),
    );
  }

  getTargetTimbang() {
    if (timbang.listProduk.isNotEmpty) {
      return timbang.listProduk
              .map((e) => e.targetBerat)
              .reduce((value, element) => value + element)
              .toString() +
          " Kg";
    } else {
      return "0 Kg";
    }
  }

  getTargetJumlah() {
    if (timbang.listProduk.isNotEmpty) {
      return timbang.listProduk
              .map((e) => e.targetJumlah)
              .reduce((value, element) => value + element)
              .toString() +
          " Pcs";
    } else {
      return "0 Pcs";
    }
  }
}
