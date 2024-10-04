import 'package:dart_journal_domain/dart_journal_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_journal_app/l10n/l10n_gen/app_localizations.dart';
import 'package:flutter_journal_app/src/utils/utils.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';
import 'package:provider/provider.dart';

class EntryInputForm extends StatefulWidget {
  const EntryInputForm({super.key});

  @override
  State<EntryInputForm> createState() => _EntryInputFormState();
}

class _EntryInputFormState extends State<EntryInputForm> {
  late final EntryController _controller;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textController;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = context.read<EntryController>();
    _textController = TextEditingController();
  }

  void _saveEntry() async {
    if (_formKey.currentState!.validate()) {
      final newEntry = NewEntry(
        tags: StringUtils.getTags(_textController.text),
        text: StringUtils.getText(_textController.text),
      );
      _textController.clear();
      _controller.create(newEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: appLocalizations.entry_hint,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const RotatedBox(
              quarterTurns: 3,
              child: Icon(Icons.send),
            ),
            onPressed: _saveEntry,
          ),
        ),
        minLines: 1,
        maxLines: 3,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return appLocalizations.entry_hint;
          }
          return null;
        },
      ),
    );
  }
}
