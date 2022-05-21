import 'dart:io';

import 'package:aplikasi_timbang/bloc/timbang/timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_state.dart';
import 'package:aplikasi_timbang/components/pages/menu_page.dart';
import 'package:aplikasi_timbang/components/widgets/hasil_timbang.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DaftarTimbangPage extends StatefulWidget {
  const DaftarTimbangPage({Key? key}) : super(key: key);

  @override
  State<DaftarTimbangPage> createState() => _DaftarTimbangPageState();
}

class _DaftarTimbangPageState extends State<DaftarTimbangPage> {
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
                  onPressed: getVerifikasiDialog,
                  child: const Text("Simpan dan Verifikasi Hasil Timbang"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void getVerifikasiDialog() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(16),
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Verifikasi Petugas Kandang",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text("Kirim foto data timbang"),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final imagePicker = ImagePicker();
                          var result = await imagePicker.pickImage(
                              source: ImageSource.camera);

                          if (result != null) {
                            setState(() {
                              buktiTimbang = File(result.path);
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: buktiTimbang != null
                              ? Image(
                                  image: FileImage(buktiTimbang!),
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.camera),
                                      Text("Tekan disini untuk mengambil foto"),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            tampilkanDialogSukses();
                          },
                          child: const Text("Simpan dan Kirim Hasil Timbang"),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ));
  }

  File? buktiTimbang;

  void tampilkanDialogSukses() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Verifikasi Berhasil",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuPage(),
                              ),
                              (route) => false);
                        },
                        child: const Text("Kembali ke Menu Utama"),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
