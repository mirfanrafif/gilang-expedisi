import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/list_so/list_so_bloc.dart';
import '../../utils/constants.dart';
import '../components/timbang_card.dart';

class RiwayatSO extends StatefulWidget {
  const RiwayatSO({Key? key}) : super(key: key);

  @override
  State<RiwayatSO> createState() => _RiwayatSOState();
}

class _RiwayatSOState extends State<RiwayatSO> {
  var selectedJobType = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListSoBloc, ListSoState>(
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
                        return TimbangCard(
                            timbang: state.completedTimbang[index]);
                      },
                      itemCount: state.completedTimbang.length,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        );
      },
    );
  }

  final _cariSoController = TextEditingController();

  Widget _getSearchSo() {
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
