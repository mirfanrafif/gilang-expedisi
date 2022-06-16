import 'package:aplikasi_timbang/bloc/timbang/timbang_event.dart';
import 'package:aplikasi_timbang/components/widgets/riwayat_timbang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/timbang/timbang_bloc.dart';
import '../../bloc/timbang/timbang_state.dart';

class RiwayatTimbangPage extends StatefulWidget {
  const RiwayatTimbangPage({Key? key}) : super(key: key);

  @override
  State<RiwayatTimbangPage> createState() => _RiwayatTimbangPageState();
}

class _RiwayatTimbangPageState extends State<RiwayatTimbangPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TimbangBloc>().add(LoadTimbangEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Timbang"),
      ),
      body: BlocBuilder<TimbangBloc, TimbangState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: "No. SO",
                    filled: true,
                    fillColor: Colors.black12,
                  ),
                  controller: _controller,
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(child: getHistoryTimbangList(state))
              ],
            ),
          );
        },
      ),
    );
  }

  getHistoryTimbangList(TimbangState state) {
    if (state is TimbangLoaded) {
      return ListView.builder(
        itemBuilder: (context, index) =>
            RiwayatTimbangItem(timbang: state.listTimbang[index]),
        itemCount: state.listTimbang.length,
      );
    } else {
      return const Center(
        child: Text("Tidak ada riwayat timbang"),
      );
    }
  }
}
