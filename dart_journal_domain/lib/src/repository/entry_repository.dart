import 'package:dart_journal_domain/dart_journal_domain.dart';

abstract class EntryRepository {
  Future<List<Entry>> getAll();

  Future<void> create(Entry entry);

  Future<void> update(Entry entry);

  Future<void> delete(Entry entry);
}
