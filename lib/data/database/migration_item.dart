import 'package:sqflite/sqflite.dart';

class MigrationItem {
  final List<String> migrationQueryList;
  final int from;
  final int to;

  const MigrationItem({
    required this.migrationQueryList,
    required this.from,
    required this.to,
  });

  Future<bool> run(Database db) async {
    try {
      for (var query in migrationQueryList) {
        await db.execute(query);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
