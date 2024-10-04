import 'dart:async';

import 'package:dart_journal_data/dart_journal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';
import 'package:logging/logging.dart';

abstract class Injector {
  EntryController get entryController;

  Stream<bool> get initializationStream;

  bool get initialized;

  void dispose();

  Future<void> initialize();
}

class DefaultInjector implements Injector {
  final _initializationStreamController = StreamController<bool>.broadcast();

  var _initialized = false;

  late EntryController _entryController;

  @override
  EntryController get entryController => _entryController;

  @override
  Stream<bool> get initializationStream =>
      _initializationStreamController.stream;

  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    });

    final entryRepository = SqfliteEntryRepository();
    await entryRepository.initialize();

    _entryController = EntryController(repository: entryRepository);

    _initialized = true;
    _initializationStreamController.add(_initialized);
  }

  @override
  void dispose() {
    _initialized = false;
    _initializationStreamController.add(_initialized);
    _initializationStreamController.close();
  }

  @override
  bool get initialized => _initialized;
}
