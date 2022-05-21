import 'package:aplikasi_timbang/components/pages/tambah_timbang_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ayam Hidup",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text("Jumlah Kg:"),
            const SizedBox(
              height: 16,
            ),
            Text("Catatan:"),
            Text("-"),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TambahTimbangPage(),
                      ));
                },
                child: Text("Mulai Timbang"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
