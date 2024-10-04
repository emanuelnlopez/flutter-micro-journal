import 'package:dart_journal_domain/dart_journal_domain.dart';

class Entry extends NewEntry {
  Entry({
    super.tags,
    required super.text,
    required this.id,
  });

  factory Entry.fromNewEntry(
    NewEntry newEntry, {
    required int id,
  }) =>
      Entry(
        tags: newEntry.tags,
        text: newEntry.text,
        id: id,
      );

  final int id;
}
