import 'package:dart_journal_domain/dart_journal_domain.dart';

class PresentationEntry extends Entry {
  PresentationEntry({
    super.tags,
    required super.text,
    required super.id,
  });

  factory PresentationEntry.fromEntry(Entry entry) => PresentationEntry(
        tags: entry.tags,
        text: entry.text,
        id: entry.id,
      );

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(id);
}
