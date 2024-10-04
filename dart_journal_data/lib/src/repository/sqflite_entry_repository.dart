import 'package:dart_journal_data/dart_journal_data.dart';
import 'package:dart_journal_domain/dart_journal_domain.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteEntryRepository implements EntryRepository {
  late final Database _database;

  Future<void> initialize() async {
    // _logger.finest('Getting file reference...');
    // final file = File('assets/sql/create_entries_table.sql');
    // String? createStatement;

    // if (await file.exists()) {
    //   _logger.finest('Reading file contents...');
    //   createStatement = await file.readAsString();

    //   if (createStatement.isNotEmpty) {
    //     _logger.finest('Opening database...');
    //     _database = await openDatabase(
    //       join(await getDatabasesPath(), 'entries_database.db'),
    //       onCreate: (db, version) => db.execute(createStatement!),
    //       version: 1,
    //     );
    //   }
    // }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'entries_database.db'),
      onCreate: (db, version) => db.execute(
        'CREATE TABLE entries (id INTEGER PRIMARY KEY, content TEXT NOT NULL, tags TEXT NOT NULL);',
      ),
      version: 1,
    );
  }

  @override
  Future<void> create(Entry entry) async {
    final dbEntry = SqfliteEntry.fromEntry(entry);
    await _database.insert(SqfliteEntryKeys.tableName, dbEntry.toMap());
  }

  @override
  Future<void> delete(Entry entry) async {
    await _database.delete(
      SqfliteEntryKeys.tableName,
      where: '${SqfliteEntryKeys.id} = ?',
      whereArgs: [entry.id],
    );
  }

  @override
  Future<List<Entry>> getAll() async {
    final result = await _database.query(SqfliteEntryKeys.tableName);
    final entries = SqfliteEntry.fromMapList(result);
    return entries;
  }

  @override
  Future<void> update(Entry entry) async {
    final dbEntry = SqfliteEntry.fromEntry(entry);
    await _database.update(
      SqfliteEntryKeys.tableName,
      dbEntry.toMap(),
      where: '${SqfliteEntryKeys.id} = ?',
      whereArgs: [entry.id],
    );
  }
}
