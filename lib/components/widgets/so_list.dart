import 'package:flutter/material.dart';

class SoList extends StatefulWidget {
  const SoList({Key? key}) : super(key: key);

  @override
  State<SoList> createState() => _SoListState();
}

class _SoListState extends State<SoList> {
  var selectedJobType = 1;

  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "SO No. 123",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text("Nama Kandang: "),
                        Text('Tanggal pemesanan: '),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Alamat Kandang: "),
                            Expanded(child: Text('')),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 3,
            ),
          )
        ],
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
