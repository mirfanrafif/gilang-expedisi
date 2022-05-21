import 'package:aplikasi_timbang/components/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CariSOPage extends StatefulWidget {
  const CariSOPage({Key? key}) : super(key: key);

  @override
  State<CariSOPage> createState() => _CariSOPageState();
}

class _CariSOPageState extends State<CariSOPage> {
  final _cariSoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cari SO"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
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
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Kandang: "),
                    Text("Alamat Kandang: "),
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
            ProductCard(),
            ProductCard(),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}
