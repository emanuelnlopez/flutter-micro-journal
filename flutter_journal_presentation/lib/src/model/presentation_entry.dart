import 'package:dart_journal_domain/dart_journal_domain.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';

class PresentationEntry extends Entry {
  PresentationEntry({
    super.tags,
    required super.text,
    required super.uuid,
  });

  factory PresentationEntry.fromEntry(Entry entry) => PresentationEntry(
        tags: entry.tags,
        text: entry.text,
        uuid: entry.uuid,
      );

  DateTime get dateTime => DateTimeUtils.uuidToDateTime(uuid);
}
