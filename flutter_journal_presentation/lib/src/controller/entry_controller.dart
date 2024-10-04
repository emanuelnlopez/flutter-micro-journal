import 'dart:async';

import 'package:dart_journal_domain/dart_journal_domain.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';
import 'package:uuid/uuid.dart';

class EntryController {
  EntryController({
    required EntryRepository repository,
  }) : _repository = repository;

  final _entriesStreamController =
      StreamController<List<PresentationEntry>>.broadcast();

  final EntryRepository _repository;

  Stream<List<PresentationEntry>> get entriesStream =>
      _entriesStreamController.stream;

  void create(NewEntry newEntry) async {
    final entry = Entry.fromNewEntry(newEntry, uuid: const Uuid().v1());
    await _repository.create(entry);
    getAll();
  }

  void update(Entry entry) async {
    await _repository.update(entry);
    getAll();
  }

  void delete(Entry entry) async {
    await _repository.delete(entry);
    getAll();
  }

  void getAll() async {
    final entries = await _repository.getAll();
    final presentationEntries =
        entries.map((entry) => PresentationEntry.fromEntry(entry)).toList();
    _entriesStreamController.add(presentationEntries);
  }
}
