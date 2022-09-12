import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/components/product_card.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:aplikasi_timbang/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'assigned_job_list_page.dart';

class ProductListToCountPage extends StatefulWidget {
  const ProductListToCountPage({Key? key}) : super(key: key);

  @override
  State<ProductListToCountPage> createState() => _ProductListToCountPageState();
}

class _ProductListToCountPageState extends State<ProductListToCountPage> {
  final _cariSoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoBloc, SoState>(
      listener: (context, state) {
        if (state is SoComplete) {
          //dialog selesai timbang semua produk
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
                                builder: (context) =>
                                    const AssignedJobListPage(),
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
            title: const Text("Detail PO"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...getSoDetail(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> getSoDetail(SoState state) {
    if (state is SoSelected) {
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
                      GilangDateUtils.getTanggalPemesanan(
                          state.timbang.tanggalPemesanan, context),
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
        //List produk
        getProductListCard(state),
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

  Widget getProductListCard(SoSelected state) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: state.timbang.listProduk
          .map((e) => ProductToCountCard(
                timbang: state.timbang,
                produk: e,
              ))
          .toList(),
    ));
  }

  Widget getAlamatKandangText(SoSelected state) {
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

  Widget getSelesaiTimbangBtn(SoSelected state) {
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
