import 'package:aplikasi_timbang/components/widgets/so_list.dart';
import 'package:flutter/material.dart';

class AssignedJobListPage extends StatefulWidget {
  const AssignedJobListPage({Key? key}) : super(key: key);

  @override
  State<AssignedJobListPage> createState() => _AssignedJobListPageState();
}

class _AssignedJobListPageState extends State<AssignedJobListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Halo, Irfan'),
          leading: ClipOval(
            child: Container(
              color: Colors.black12,
              child: const Icon(
                Icons.person,
                color: Colors.black45,
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Daftar Tugas'),
              ),
              Tab(
                child: Text('Riwayat Timbang'),
              )
            ],
          ),
        ),
        body: TabBarView(children: [const SoList(), Container()]),
      ),
    );
  }
}
