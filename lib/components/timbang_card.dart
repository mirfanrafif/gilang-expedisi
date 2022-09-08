import 'package:flutter/material.dart';

import '../../data/models/timbang.dart';
import '../../utils/date_utils.dart';

class TimbangCard extends StatelessWidget {
  final Timbang timbang;

  const TimbangCard({Key? key, required this.timbang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "SO No. ${timbang.soId}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text("Nama Kandang: " + timbang.namaKandang),
              Text(
                'Tanggal pemesanan: ' +
                    GilangDateUtils.getTanggalPemesanan(
                      timbang.tanggalPemesanan,
                      context,
                    ),
              ),
              ...(timbang.alamatKandang.isNotEmpty
                  ? [
                      Text("Alamat Kandang: "),
                      Text(timbang.alamatKandang),
                    ]
                  : []),
            ],
          ),
        ),
      ),
    );
  }
}
