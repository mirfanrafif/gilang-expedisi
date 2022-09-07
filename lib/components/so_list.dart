import 'package:aplikasi_timbang/components/timbang_card.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/list_so/list_so_bloc.dart';
import '../../bloc/so/so_bloc.dart';
import '../pages/cari_so_page.dart';

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
            ),
          );
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              child: TimbangCard(
                                timbang: state.timbang[index],
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
