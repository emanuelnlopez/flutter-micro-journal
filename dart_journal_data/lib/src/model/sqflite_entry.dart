import 'package:dart_journal_domain/dart_journal_domain.dart';

class SqfliteEntry extends Entry {
  SqfliteEntry({
    super.tags,
    required super.text,
    required super.id,
  });

  static List<SqfliteEntry> fromMapList(List<Map<String, dynamic>> maps) {
    final result = <SqfliteEntry>[];

    for (dynamic map in maps) {
      result.add(SqfliteEntry.fromMap(map));
    }

    return result;
  }

  factory SqfliteEntry.fromEntry(Entry entry) => SqfliteEntry(
        tags: entry.tags,
        text: entry.text,
        id: entry.id,
      );

  factory SqfliteEntry.fromMap(Map<String, dynamic> map) => SqfliteEntry(
        tags: map[SqfliteEntryKeys.tags]?.isNotEmpty == true
            ? map[SqfliteEntryKeys.tags].split(', ')
            : [],
        text: map[SqfliteEntryKeys.text],
        id: map[SqfliteEntryKeys.id],
      );

  Map<String, dynamic> toMap() => {
        SqfliteEntryKeys.tags: tags.join(', '),
        SqfliteEntryKeys.text: text,
        SqfliteEntryKeys.id: id,
      };
}

abstract class SqfliteEntryKeys {
  static final tableName = 'entries';
  static final tags = 'tags';
  static final text = 'content';
  static final id = 'id';
}
