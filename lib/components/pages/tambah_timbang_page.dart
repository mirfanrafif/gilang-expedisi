import 'package:flutter/material.dart';

class TambahTimbangPage extends StatefulWidget {
  const TambahTimbangPage({Key? key}) : super(key: key);

  @override
  State<TambahTimbangPage> createState() => _TambahTimbangPageState();
}

class _TambahTimbangPageState extends State<TambahTimbangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Timbang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Center(
              child: Text("Masukkan Jumlah Timbang"),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.red.shade100,
                    ),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Kg",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: Text(
                "Target: 1000 Kg",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            //Jumlah Ekor
            const Center(
              child: Text("Masukkan Jumlah Ekor"),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.lightGreen.shade100,
                    ),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Ekor",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: Text(
                "Target: 400 Ekor",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            //Tombol tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Kembali ke Sebelumnya", maxLines: 2),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 242, 242, 242),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: SizedBox(
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Tambah Timbang",
                        maxLines: 2,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 242, 242, 242),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Selesai Timbang"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
