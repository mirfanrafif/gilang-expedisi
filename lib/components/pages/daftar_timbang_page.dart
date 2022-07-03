import 'dart:io';

import 'package:aplikasi_timbang/bloc/detail_timbang/detail_timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/components/pages/cari_so_page.dart';
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
      body: BlocBuilder<SoBloc, SoState>(
        builder: (context, timbang) {
          if (timbang is SoLoaded) {
            return BlocConsumer<DetailTimbangBloc, DetailTimbangState>(
                listener: (context, state) {
              if (state is UploadBuktiErrorState) {
                Navigator.pop(context);
                showErrorSnackbar(context, state.errorMessage);
              }
              if (state is UploadingBuktiTimbangState) {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Sedang mengupload bukti timbang...",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  "Mohon tunggu sebentar",
                                ),
                              ],
                            ),
                          ),
                        ));
              }
              if (state is TimbangProdukSelesaiState) {
                Navigator.pop(context);
                tampilkanDialogSukses(state, timbang.timbang);
              }
              if (state is ProcessingJobState) {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Sedang memproses hasil timbang...",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  "Mohon tunggu sebentar",
                                ),
                              ],
                            ),
                          ),
                        ));
              }
              if (state is ProcessJobSuccessState) {
                context.read<SoBloc>().add(UpdateTimbangEvent(state.timbang));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CariSOPage(),
                    ),
                    (route) => false);
              }
              if (state is DeleteTimbangDetailState) {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: const Text("Sukses menghapus data timbang"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tutup"),
                            )
                          ],
                        ));
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
                                    state.produk.targetJumlah.toString() +
                                        " Ekor",
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
                              detail: state.listDetail[index], index: index),
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
                            getVerifikasiDialog(state.produk, timbang.timbang);
                          },
                          child:
                              const Text("Simpan dan Verifikasi Hasil Timbang"),
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
            });
          } else {
            return Container();
          }
        },
      ),
    );
  }

  String getTotalTimbang(DetailTimbangState state) {
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

  String getTotalJumlah(DetailTimbangState state) {
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
                      context
                          .read<DetailTimbangBloc>()
                          .add(KirimBuktiVerifikasiEvent(
                            produk,
                            buktiTimbang!,
                          ));
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

  void tampilkanDialogSukses(TimbangProdukSelesaiState state, Timbang timbang) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const Icon(
                Icons.check,
                size: 128,
                color: Colors.green,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<DetailTimbangBloc>().add(
                      ProcessJobEvent(timbang, state.produk, state.listDetail));
                },
                child: const Text("Kembali ke Menu Utama"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
