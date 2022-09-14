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
              builder: (context) => const ProductListToCountPage(),
            ),
          );
        }
      },
      child: BlocConsumer<ListSoBloc, ListSoState>(
        listener: (context, state) {
          if (state is ListSoError) {
            showErrorSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          return Column(
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
                              context.read<SoBloc>().add(
                                    SelectSOEvent(
                                      timbang: state.timbang[index],
                                    ),
                                  );
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
          );
        },
      ),
    );
  }
}
