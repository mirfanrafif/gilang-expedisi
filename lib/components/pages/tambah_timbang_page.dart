import 'package:aplikasi_timbang/bloc/timbang/timbang_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_event.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_state.dart';
import 'package:aplikasi_timbang/components/pages/daftar_timbang_page.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TambahTimbangPage extends StatefulWidget {
  const TambahTimbangPage({Key? key}) : super(key: key);

  @override
  State<TambahTimbangPage> createState() => _TambahTimbangPageState();
}

class _TambahTimbangPageState extends State<TambahTimbangPage> {
  final _beratController = TextEditingController(text: "");
  final _jumlahController = TextEditingController(text: "");

  var _berat = 0;
  var _jumlah = 0;

  @override
  void initState() {
    super.initState();
    _beratController.addListener(() {
      var newBerat = int.tryParse(_beratController.text) ?? 0;
      setState(() {
        _berat = newBerat;
      });
    });
    _jumlahController.addListener(() {
      setState(() {
        _jumlah = int.tryParse(_jumlahController.text) ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _beratController.dispose();
    _jumlahController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Timbang"),
      ),
      body: BlocBuilder<TimbangBloc, TimbangState>(
        builder: (context, state) => Padding(
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _beratController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0",
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: (state.listTimbang.isNotEmpty
                                    ? state.listTimbang
                                        .map((e) => e.berat)
                                        .reduce(
                                            (value, element) => value + element)
                                    : 0) >=
                                state.targetBerat
                            ? Colors.lightGreen.shade100
                            : Colors.red.shade100,
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
                  "Target: " + state.targetBerat.toString() + " Kg",
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
                        fillColor: (state.listTimbang.isNotEmpty
                                    ? state.listTimbang
                                        .map((e) => e.jumlah)
                                        .reduce(
                                            (value, element) => value + element)
                                    : 0) >=
                                state.targetEkor
                            ? Colors.lightGreen.shade100
                            : Colors.red.shade100,
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
                  "Target: " + state.targetEkor.toString() + " Ekor",
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
                        onPressed: () {},
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
                                    content: Text("Berat tidak boleh kosong")));
                          }

                          var timbang = Timbang(_berat, _jumlah);
                          context
                              .read<TimbangBloc>()
                              .add(TambahTimbangEvent(timbang));
                          _beratController.text = "";
                          _jumlahController.text = "";
                          setState(() {
                            _jumlah = 0;
                            _berat = 0;
                          });
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
        ),
      ),
    );
  }
}
