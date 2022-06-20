import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/components/pages/menu_page.dart';
import 'package:aplikasi_timbang/components/widgets/product_card.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CariSOPage extends StatefulWidget {
  const CariSOPage({Key? key}) : super(key: key);

  @override
  State<CariSOPage> createState() => _CariSOPageState();
}

class _CariSOPageState extends State<CariSOPage> {
  final _cariSoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoBloc, SoState>(
      listener: (context, state) {
        if (state is SoNotFound) {
          showErrorSnackbar(context, state.message);
        }
        if (state is SoComplete) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Timbang Selesai",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                            context.read<SoBloc>().add(ResetSoEvent());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuPage(),
                              ),
                            );
                          },
                          child: const Text("Kembali ke Menu"),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cari PO"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSearchSo(), //Text Field untuk cari SO
                  const SizedBox(
                    height: 16,
                  ),
                  ...getSoDetail(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getSearchSo() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: "No. PO",
              filled: true,
              fillColor: Colors.black12,
            ),
            keyboardType: TextInputType.number,
            controller: _cariSoController,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        ClipOval(
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).primaryColor,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_cariSoController.text.isNotEmpty) {
                  int id = int.parse(_cariSoController.text);
                  context.read<SoBloc>().add(CariSoEvent(id: id));
                }
              },
              splashColor: Colors.white,
              highlightColor: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  List<Widget> getSoDetail(SoState state) {
    if (state is SoLoaded) {
      return [
        Card(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SO No. " + state.timbang.soId.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text("Nama Kandang: " + state.timbang.namaKandang),
                Text(
                  'Tanggal pemesanan: ' +
                      getTanggalPemesanan(state.timbang.tanggalPemesanan),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat Kandang: "),
                    Expanded(child: getAlamatKandangText(state)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text("Produk:"),
        const SizedBox(
          height: 16,
        ),
        ...state.timbang.listProduk
            .map((e) => ProductCard(
                  timbang: state.timbang,
                  produk: e,
                ))
            .toList(),
        const SizedBox(
          height: 16,
        ),
        getSelesaiTimbangBtn(state)
      ];
    } else if (state is SoLoading) {
      return [
        const Center(
          child: CircularProgressIndicator(),
        )
      ];
    } else {
      return [];
    }
  }

  Widget getAlamatKandangText(SoLoaded state) {
    var alamatKandang = state.timbang.alamatKandang;
    if (alamatKandang.contains(RegExp(r'https?:\/\/.*'))) {
      return GestureDetector(
        child: Text(
          state.timbang.alamatKandang,
          style: TextStyle(color: Colors.blue.shade900),
        ),
        onTap: () async {
          if (!(await launchUrl(
            Uri.parse(alamatKandang),
            mode: LaunchMode.externalApplication,
          ))) {
            showErrorSnackbar(context, 'Tidak dapat membuka link');
          }
        },
      );
    } else {
      return Text(state.timbang.alamatKandang);
    }
  }

  String getTanggalPemesanan(DateTime tanggalPemesanan) {
    // initializeDateFormatting('id_ID', filePath)
    return DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString())
        .format(tanggalPemesanan);
  }

  Widget getSelesaiTimbangBtn(SoLoaded state) {
    var selesaiTimbangSemuaBarang = state.timbang.listProduk
        .where((element) => element.selesaiTimbang == false)
        .isNotEmpty;
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: selesaiTimbangSemuaBarang
            ? null
            : () {
                context.read<SoBloc>().add(CompleteJobEvent(state.timbang));
              },
        child: Text(selesaiTimbangSemuaBarang
            ? "Selesaikan menimbang semua produk"
            : "Selesai Timbang"),
        style: ButtonStyle(
          backgroundColor: selesaiTimbangSemuaBarang
              ? MaterialStateProperty.all(Colors.black12)
              : null,
        ),
      ),
    );
  }
}
