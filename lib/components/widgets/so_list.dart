import 'package:aplikasi_timbang/bloc/bloc/list_so_bloc.dart';
import 'package:aplikasi_timbang/components/pages/cari_so_page.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:aplikasi_timbang/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/so/so_bloc.dart';

class SoList extends StatefulWidget {
  const SoList({Key? key}) : super(key: key);

  @override
  State<SoList> createState() => _SoListState();
}

class _SoListState extends State<SoList> {
  var selectedJobType = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SoBloc, SoState>(
      listener: (context, state) {
        if (state is SoSelected) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CariSOPage(),
              ));
        }
      },
      child: BlocConsumer<ListSoBloc, ListSoState>(
        listener: (context, state) {
          //TODO: Listen ketika gagal ambil SO
          if (state is ListSoError) {
            showErrorSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(25, 0, 0, 0),
                          blurRadius: 4,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButton<int>(
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem<int>(
                          child: Text('SO dan DO'),
                          value: 1,
                        ),
                        DropdownMenuItem<int>(
                          child: Text('SO'),
                          value: 2,
                        ),
                        DropdownMenuItem<int>(
                          child: Text('DO'),
                          value: 3,
                        ),
                      ],
                      onChanged: (int? newValue) {
                        setState(() {
                          if (newValue != null) {
                            selectedJobType = newValue;
                          }
                        });
                      },
                      value: selectedJobType,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: state is ListSoLoaded
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<SoBloc>().add(SelectSOEvent(
                                    timbang: state.timbang[index]));
                              },
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "SO No. ${state.timbang[index].soId}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text("Nama Kandang: " +
                                          state.timbang[index].namaKandang),
                                      Text(
                                        'Tanggal pemesanan: ' +
                                            GilangDateUtils.getTanggalPemesanan(
                                              state.timbang[index]
                                                  .tanggalPemesanan,
                                              context,
                                            ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Alamat Kandang: "),
                                          Expanded(
                                              child: Text(state.timbang[index]
                                                  .alamatKandang)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: state.timbang.length,
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final _cariSoController = TextEditingController();

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
              onPressed: () {},
              splashColor: Colors.white,
              highlightColor: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
