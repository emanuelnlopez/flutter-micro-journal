import 'package:dart_journal_domain/dart_journal_domain.dart';

class Entry extends NewEntry {
  Entry({
    super.tags,
    required super.text,
    required this.uuid,
  });

  factory Entry.fromNewEntry(
    NewEntry newEntry, {
    required String uuid,
  }) =>
      Entry(
        tags: newEntry.tags,
        text: newEntry.text,
        uuid: uuid,
      );

  final String uuid;
}
