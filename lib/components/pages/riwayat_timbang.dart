import 'package:aplikasi_timbang/components/widgets/riwayat_timbang.dart';
import 'package:flutter/material.dart';

class RiwayatTimbangPage extends StatefulWidget {
  const RiwayatTimbangPage({Key? key}) : super(key: key);

  @override
  State<RiwayatTimbangPage> createState() => _RiwayatTimbangPageState();
}

class _RiwayatTimbangPageState extends State<RiwayatTimbangPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Timbang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: "No. SO",
                filled: true,
                fillColor: Colors.black12,
              ),
              controller: _controller,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: ListView(
              children: [
                RiwayatTimbangItem(),
                RiwayatTimbangItem(),
                RiwayatTimbangItem(),
                RiwayatTimbangItem(),
                RiwayatTimbangItem(),
                RiwayatTimbangItem(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
