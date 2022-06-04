import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/components/widgets/product_card.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cari SO"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text Field untuk cari SO
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "No. SO",
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
                  ),
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
                Text("Alamat Kandang: " + state.timbang.alamatKandang),
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
                  produk: e,
                ))
            .toList(),
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
}
