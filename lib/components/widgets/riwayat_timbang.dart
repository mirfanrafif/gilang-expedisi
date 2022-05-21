import 'package:flutter/material.dart';

class RiwayatTimbangItem extends StatelessWidget {
  const RiwayatTimbangItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SO #1234",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text("Status: Selesai"),
                Text("24 September 2021")
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("2000 Kg"),
                Text("400 Ekor"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
