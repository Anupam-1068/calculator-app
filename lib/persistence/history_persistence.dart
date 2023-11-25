import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryPersistence {
  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'calculator_history.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, calculation TEXT, timestamp TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> addToHistory(String calculation) async {
    await initDatabase();
    await _database.insert(
      'history',
      {'calculation': calculation, 'timestamp': DateTime.now().toString()},
    );
  }

  Future<List<String>> getHistory() async {
    await initDatabase();
    final List<Map<String, dynamic>> historyList = await _database.query('history');

    return historyList.map((map) {
      final String calculation = map['calculation'];
      final String timestamp = map['timestamp'];
      return '$calculation - $timestamp';
    }).toList();
  }

  // Method to clear history
  void clear() async {
    await initDatabase();
    await _database.delete('history');
  }
}
