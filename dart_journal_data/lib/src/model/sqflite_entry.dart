import 'package:dart_journal_domain/dart_journal_domain.dart';

class SqfliteEntry extends Entry {
  SqfliteEntry({
    super.tags,
    required super.text,
    required super.uuid,
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
        uuid: entry.uuid,
      );

  factory SqfliteEntry.fromMap(Map<String, dynamic> map) => SqfliteEntry(
        tags: map[SqfliteEntryKeys.tags]?.isNotEmpty == true
            ? map[SqfliteEntryKeys.tags].split(', ')
            : [],
        text: map[SqfliteEntryKeys.text],
        uuid: map[SqfliteEntryKeys.uuid],
      );

  Map<String, dynamic> toMap() => {
        SqfliteEntryKeys.tags: tags.join(', '),
        SqfliteEntryKeys.text: text,
        SqfliteEntryKeys.uuid: uuid,
      };
}

abstract class SqfliteEntryKeys {
  static final tableName = 'entries';
  static final tags = 'tags';
  static final text = 'content';
  static final uuid = 'uuid';
}
