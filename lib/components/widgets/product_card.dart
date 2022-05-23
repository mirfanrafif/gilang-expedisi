import 'package:aplikasi_timbang/components/pages/tambah_timbang_page.dart';
import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/timbang_detail/timbang_detail_bloc.dart';

class ProductCard extends StatelessWidget {
  final TimbangProduk produk;
  const ProductCard({Key? key, required this.produk}) : super(key: key);

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
            SizedBox(
              width: double.infinity,
              height: 40,
              child: BlocBuilder<TimbangDetailBloc, TimbangDetailState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<TimbangDetailBloc>()
                          .add(SetTimbangProdukEvent(produk));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TambahTimbangPage(
                              produk: produk,
                            ),
                          ));
                    },
                    child: const Text("Mulai Timbang"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
