import 'package:flutter/material.dart';
import 'package:flutter_journal_app/src/ui/ui.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';

class EntryListItem extends StatelessWidget {
  const EntryListItem({
    required this.entry,
    super.key,
  });

  final PresentationEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(entry.text),
          if (entry.tags.isNotEmpty)
            Row(
              children: entry.tags
                  .map((tag) => Chip(
                        padding: const EdgeInsets.all(Spacing.xsmall),
                        label: Text(tag),
                      ))
                  .toList(),
            ),
          SizedBox(
            width: double.infinity,
            child: Text(
              DateTimeUtils.geDateFormat(DateTimeUtils.fullDateTimeFormat)
                  .format(entry.dateTime),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
