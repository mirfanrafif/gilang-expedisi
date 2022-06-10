import 'dart:io';

import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/components/pages/cari_so_page.dart';
import 'package:aplikasi_timbang/components/pages/menu_page.dart';
import 'package:aplikasi_timbang/components/widgets/hasil_timbang.dart';
import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/timbang.dart';

class DaftarTimbangPage extends StatefulWidget {
  const DaftarTimbangPage({Key? key}) : super(key: key);

  @override
  State<DaftarTimbangPage> createState() => _DaftarTimbangPageState();
}

class _DaftarTimbangPageState extends State<DaftarTimbangPage> {
  File? buktiTimbang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Timbang")),
      body: BlocConsumer<SoBloc, SoState>(listener: (context, state) {
        if (state is UploadBuktiErrorState) {
          showErrorSnackbar(context, state.errorMessage);
        }
        if (state is TimbangProdukSelesaiState) {
          tampilkanDialogSukses(state);
        }
        if (state is SoLoaded) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CariSOPage(),
              ),
              (route) => false);
        }
      }, builder: (context, state) {
        if (state is SelectedProductState) {
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
                              getTotalTimbang(state) + " Kg",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              getTotalJumlah(state) + " Ekor",
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
                              state.produk.targetBerat.toString() + " Kg",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.produk.targetJumlah.toString() + " Ekor",
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
                        timbang: state.listDetail[index], index: index + 1),
                    itemCount: state.listDetail.length,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      getVerifikasiDialog(state.produk, state.timbang);
                    },
                    child: const Text("Simpan dan Verifikasi Hasil Timbang"),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  String getTotalTimbang(SoState state) {
    if (state is SelectedProductState) {
      return state.listDetail.isNotEmpty
          ? state.listDetail
              .map((e) => e.berat)
              .reduce((value, element) => value + element)
              .toString()
          : '0';
    } else {
      return '0';
    }
  }

  String getTotalJumlah(SoState state) {
    if (state is SelectedProductState) {
      return state.listDetail.isNotEmpty
          ? state.listDetail
              .map((e) => e.jumlah)
              .reduce((value, element) => value + element)
              .toString()
          : '0';
    } else {
      return '0';
    }
  }

  void getVerifikasiDialog(TimbangProduk produk, Timbang timbang) {
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
                    var result =
                        await imagePicker.pickImage(source: ImageSource.camera);

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
                      if (buktiTimbang == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Mohon foto data timbang"),
                          ),
                        );
                        return;
                      }
                      context.read<SoBloc>().add(KirimBuktiVerifikasiEvent(
                            timbang,
                            produk,
                            buktiTimbang!,
                          ));
                      Navigator.pop(context);
                    },
                    child: const Text("Simpan dan Kirim Hasil Timbang"),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  void tampilkanDialogSukses(TimbangProdukSelesaiState state) {
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
                    context.read<SoBloc>().add(ProcessJobEvent(
                        state.timbang, state.produk, state.listDetail));
                  },
                  child: const Text("Kembali ke Menu Utama"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
