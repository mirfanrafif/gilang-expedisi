import 'package:aplikasi_timbang/components/pages/daftar_timbang_page.dart';
import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/timbang_detail/timbang_detail_bloc.dart';

class TambahTimbangPage extends StatefulWidget {
  final TimbangProduk produk;
  const TambahTimbangPage({Key? key, required this.produk}) : super(key: key);

  @override
  State<TambahTimbangPage> createState() => _TambahTimbangPageState();
}

class _TambahTimbangPageState extends State<TambahTimbangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Timbang"),
      ),
      body: BlocBuilder<TimbangDetailBloc, TimbangDetailState>(
        builder: (context, state) {
          var _beratController = TextEditingController(
              text: state is PreviousTimbangDetailState
                  ? state.previous.berat.toString()
                  : "");

          var _jumlahController = TextEditingController(
              text: state is PreviousTimbangDetailState
                  ? state.previous.jumlah.toString()
                  : "");

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const Center(
                  child: Text("Masukkan Jumlah Timbang"),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _beratController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0",
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: getTargetBeratColor(state),
                        ),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      "Kg",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    getTargetBeratText(state),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                //Jumlah Ekor
                const Center(
                  child: Text("Masukkan Jumlah Ekor"),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _jumlahController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: getTargetJumlahColor(state),
                        ),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      "Ekor",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    getTargetJumlahText(state),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                //Tombol tombol
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            if (state is SelectedProductState) {
                              context
                                  .read<TimbangDetailBloc>()
                                  .add(TimbangUlangSebelumnya(state.produk));
                            }
                          },
                          child: const Text(
                            "Kembali ke Sebelumnya",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 242, 242, 242),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            var _jumlah =
                                int.tryParse(_jumlahController.text) ?? 0;
                            var _berat =
                                int.tryParse(_beratController.text) ?? 0;

                            if (_jumlah == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Jumlah tidak boleh kosong")));
                              return;
                            }

                            if (_berat == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Berat tidak boleh kosong")));
                              return;
                            }

                            if (state is SelectedProductState) {
                              var timbang = TimbangDetail(
                                  _berat, _jumlah, state.produk.id!);
                              context.read<TimbangDetailBloc>().add(
                                  TambahDetailTimbangEvent(
                                      timbang, state.produk));
                              _beratController.text = "";
                              _jumlahController.text = "";
                              setState(() {
                                _jumlah = 0;
                                _berat = 0;
                              });
                            } else if (state is PreviousTimbangDetailState) {
                              var timbang = state.previous;
                              timbang.berat = _berat;
                              timbang.jumlah = _jumlah;
                              context.read<TimbangDetailBloc>().add(
                                  TambahDetailTimbangEvent(
                                      timbang, state.produk));
                              _beratController.text = "";
                              _jumlahController.text = "";
                              setState(() {
                                _jumlah = 0;
                                _berat = 0;
                              });
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Sukses menambahkan hasil timbang")));
                          },
                          child: const Text(
                            "Tambah Timbang",
                            maxLines: 2,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 242, 242, 242),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 56,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DaftarTimbangPage(),
                        ),
                      );
                    },
                    child: const Text("Selesai Timbang"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Color getTargetBeratColor(TimbangDetailState state) {
    if (state is SelectedProductState) {
      return (state.listDetail.isNotEmpty
                  ? state.listDetail
                      .map((e) => e.berat)
                      .reduce((value, element) => value + element)
                  : 0) >=
              state.produk.targetBerat
          ? Colors.lightGreen.shade100
          : Colors.red.shade100;
    } else if (state is PreviousTimbangDetailState) {
      return (state.listDetail.isNotEmpty
                  ? state.listDetail
                      .map((e) => e.berat)
                      .reduce((value, element) => value + element)
                  : 0) >=
              state.produk.targetBerat
          ? Colors.lightGreen.shade100
          : Colors.red.shade100;
    } else {
      return Colors.white;
    }
  }

  Color getTargetJumlahColor(TimbangDetailState state) {
    if (state is SelectedProductState) {
      return (state.listDetail.isNotEmpty
                  ? state.listDetail
                      .map((e) => e.jumlah)
                      .reduce((value, element) => value + element)
                  : 0) >=
              state.produk.targetJumlah
          ? Colors.lightGreen.shade100
          : Colors.red.shade100;
    } else if (state is PreviousTimbangDetailState) {
      return (state.listDetail.isNotEmpty
                  ? state.listDetail
                      .map((e) => e.jumlah)
                      .reduce((value, element) => value + element)
                  : 0) >=
              state.produk.targetJumlah
          ? Colors.lightGreen.shade100
          : Colors.red.shade100;
    } else {
      return Colors.white;
    }
  }

  String getTargetBeratText(TimbangDetailState state) {
    if (state is SelectedProductState) {
      return "Target: " + state.produk.targetBerat.toString() + " Kg";
    } else if (state is PreviousTimbangDetailState) {
      return "Target: " + state.produk.targetBerat.toString() + " Kg";
    } else {
      return "Target: 0 Kg";
    }
  }

  String getTargetJumlahText(TimbangDetailState state) {
    if (state is SelectedProductState) {
      return "Target: " + state.produk.targetJumlah.toString() + " Ekor";
    } else if (state is PreviousTimbangDetailState) {
      return "Target: " + state.produk.targetJumlah.toString() + " Ekor";
    } else {
      return "Target: 0 Ekor";
    }
  }
}
