import 'package:aplikasi_timbang/bloc/detail_timbang/detail_timbang_bloc.dart';
import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/pages/tambah_timbang_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/timbang.dart';

class ProductCard extends StatelessWidget {
  final TimbangProduk produk;
  final Timbang timbang;

  const ProductCard({Key? key, required this.timbang, required this.produk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              produk.namaProduk,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text("Target berat: " + produk.targetBerat.toString() + " Kg"),
            const SizedBox(
              height: 16,
            ),
            const Text("Catatan:"),
            Text(produk.catatan ?? "-"),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: getSelectProdukBtn(context),
            )
          ],
        ),
      ),
    );
  }

  Widget? getSelectProdukBtn(BuildContext context) {
    if (!produk.selesaiTimbang) {
      return ElevatedButton(
        onPressed: () {
          context.read<DetailTimbangBloc>().add(SetTimbangProdukEvent(produk));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahTimbangPage(),
            ),
          );
        },
        child: const Text("Mulai Timbang"),
      );
    } else {
      return ElevatedButton(
        onPressed: null,
        child: const Text('Selesai ditimbang'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black12)),
      );
    }
  }
}
