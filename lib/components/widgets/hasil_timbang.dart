import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:flutter/material.dart';

class HasilTimbang extends StatelessWidget {
  final Timbang timbang;
  final int index;
  const HasilTimbang({
    Key? key,
    required this.timbang,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text("Timbang " + index.toString()),
            ),
            Column(
              children: [
                Text("${timbang.berat.toString()} Kg"),
                Text("${timbang.jumlah.toString()} Ekor"),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }
}
