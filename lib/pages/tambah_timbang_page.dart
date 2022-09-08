import 'package:aplikasi_timbang/bloc/detail_timbang/detail_timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'daftar_timbang_page.dart';

class TambahTimbangPage extends StatefulWidget {
  const TambahTimbangPage({Key? key}) : super(key: key);

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
      body: BlocBuilder<SoBloc, SoState>(
        builder: (context, timbang) {
          if (timbang is SoSelected) {
            return BlocBuilder<DetailTimbangBloc, DetailTimbangState>(
              builder: (context, state) {
                late TextEditingController _beratController;

                if (state is PreviousTimbangDetailState) {
                  _beratController = TextEditingController(
                      text: state.previous.berat.toString());
                } else if (state is UpdateTimbangDetailState) {
                  _beratController = TextEditingController(
                      text: state.selected.berat.toString());
                } else {
                  _beratController = TextEditingController();
                }

                late TextEditingController _jumlahController;

                if (state is PreviousTimbangDetailState) {
                  _jumlahController = TextEditingController(
                      text: state.previous.jumlah.toString());
                } else if (state is UpdateTimbangDetailState) {
                  _jumlahController = TextEditingController(
                      text: state.selected.jumlah.toString());
                } else {
                  _jumlahController = TextEditingController();
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      ...getBeratForm(state, _beratController),
                      const SizedBox(
                        height: 32,
                      ),
                      //Jumlah Ekor
                      ...getJumlahForm(state, _jumlahController),
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
                                    context.read<DetailTimbangBloc>().add(
                                        TimbangUlangSebelumnya(state.produk));
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
                                            content: Text(
                                                "Jumlah tidak boleh kosong")));
                                    return;
                                  }

                                  if (_berat == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Berat tidak boleh kosong")));
                                    return;
                                  }

                                  if (state is SelectedProductState) {
                                    var detail = TimbangDetail(
                                        _berat, _jumlah, state.produk.id);
                                    context.read<DetailTimbangBloc>().add(
                                        TambahDetailTimbangEvent(
                                            detail, state.produk));
                                    _beratController.text = "";
                                    _jumlahController.text = "";
                                    setState(() {
                                      _jumlah = 0;
                                      _berat = 0;
                                    });
                                  } else if (state
                                      is PreviousTimbangDetailState) {
                                    var detail = state.previous;
                                    detail.berat = _berat;
                                    detail.jumlah = _jumlah;
                                    context.read<DetailTimbangBloc>().add(
                                        TambahDetailTimbangEvent(
                                            detail, state.produk));
                                    _beratController.text = "";
                                    _jumlahController.text = "";
                                    setState(() {
                                      _jumlah = 0;
                                      _berat = 0;
                                    });
                                  } else if (state
                                      is UpdateTimbangDetailState) {
                                    var detail = state.selected;
                                    detail.berat = _berat;
                                    detail.jumlah = _jumlah;
                                    context
                                        .read<DetailTimbangBloc>()
                                        .add(SubmitUpdateTimbangEvent(
                                          state.produk,
                                          detail,
                                          state.position,
                                        ));
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
                                          "Sukses menambahkan hasil timbang"),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Tambah Timbang",
                                  maxLines: 2,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
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
                            if (state is SelectedProductState) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DaftarTimbangPage(),
                                ),
                              );
                            } else {
                              showErrorSnackbar(context,
                                  "Selesaikan dahulu timbang yang diubah");
                            }
                          },
                          child: const Text("Selesai Timbang"),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Color getTargetBeratColor(DetailTimbangState state) {
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
    } else if (state is UpdateTimbangDetailState) {
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

  Color getTargetJumlahColor(DetailTimbangState state) {
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
    } else if (state is UpdateTimbangDetailState) {
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

  String getTargetBeratText(DetailTimbangState state) {
    if (state is SelectedProductState) {
      return "Target: " + state.produk.targetBerat.toString() + " Kg";
    } else if (state is PreviousTimbangDetailState) {
      return "Target: " + state.produk.targetBerat.toString() + " Kg";
    } else if (state is UpdateTimbangDetailState) {
      return "Target: " + state.produk.targetBerat.toString() + " Kg";
    } else {
      return "Target: 0 Kg";
    }
  }

  List<Widget> getBeratForm(
      DetailTimbangState state, TextEditingController _beratController) {
    return [
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
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _beratController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "0",
                border: const OutlineInputBorder(borderSide: BorderSide.none),
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
          const SizedBox(
            width: 75,
            child: Text(
              "Kg",
              style: TextStyle(
                fontSize: 32,
              ),
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
    ];
  }

  List<Widget> getJumlahForm(DetailTimbangState state, _jumlahController) {
    return [
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
              decoration: const InputDecoration(
                hintText: "0",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                // fillColor: getTargetJumlahColor(state),
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
          const SizedBox(
            width: 75,
            child: Text(
              "Ekor",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      if (state is SelectedProductState)
        Center(
          child: Text(
            'Catatan: ' + (state.produk.catatan ?? ''),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      if (state is UpdateTimbangDetailState)
        Center(
          child: Text(
            'Catatan: ' + (state.produk.catatan ?? ''),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
    ];
  }
}
