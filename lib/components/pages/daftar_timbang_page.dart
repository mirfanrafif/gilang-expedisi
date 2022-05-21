import 'package:aplikasi_timbang/bloc/timbang/timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_state.dart';
import 'package:aplikasi_timbang/components/widgets/hasil_timbang.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaftarTimbangPage extends StatelessWidget {
  const DaftarTimbangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Timbang")),
      body: BlocBuilder<TimbangBloc, TimbangState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Timbang"),
                          Text(
                            state.listTimbang
                                    .map((e) => e.berat)
                                    .reduce((value, element) => value + element)
                                    .toString() +
                                " Kg",
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            state.listTimbang
                                    .map((e) => e.jumlah)
                                    .reduce((value, element) => value + element)
                                    .toString() +
                                " Ekor",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Target Timbang"),
                          Text(
                            state.targetBerat.toString() + " Kg",
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            state.targetEkor.toString() + " Ekor",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => HasilTimbang(
                      timbang: state.listTimbang[index], index: index + 1),
                  itemCount: state.listTimbang.length,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Simpan dan Verifikasi Hasil Timbang"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
