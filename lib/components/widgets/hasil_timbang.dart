import 'package:aplikasi_timbang/bloc/detail_timbang/detail_timbang_bloc.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/so/so_bloc.dart';

class HasilTimbang extends StatelessWidget {
  final TimbangDetail detail;
  final int index;
  const HasilTimbang({
    Key? key,
    required this.detail,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoBloc, SoState>(
      builder: (context, timbang) {
        if (timbang is SoLoaded) {
          return BlocBuilder<DetailTimbangBloc, DetailTimbangState>(
            builder: (context, state) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Timbang " + (index + 1).toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              if (detail.beratOld != null)
                                Text(
                                  "${detail.beratOld.toString()} Ekor",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                              Text("${detail.berat.toString()} Kg"),
                            ],
                          ),
                          Row(
                            children: [
                              if (detail.jumlahOld != null)
                                Text(
                                  "${detail.jumlahOld.toString()} Ekor",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                              Text("${detail.jumlah.toString()} Ekor"),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        color: Colors.blue.shade900,
                        onPressed: () {
                          if (state is SelectedProductState) {
                            context
                                .read<DetailTimbangBloc>()
                                .add(UpdateTimbangDetailEvent(
                                  state.produk,
                                  detail,
                                ));
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                              "Apakah kamu yakin ingin menghapus data timbang?"),
                                          const SizedBox(
                                            height: 64,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Tidak"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (state
                                                      is SelectedProductState) {
                                                    context
                                                        .read<
                                                            DetailTimbangBloc>()
                                                        .add(
                                                            DeleteTimbangDetailEvent(
                                                          state.produk,
                                                          detail,
                                                        ));
                                                  }
                                                },
                                                child: const Text("Ya"),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
