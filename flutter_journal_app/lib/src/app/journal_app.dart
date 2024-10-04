import 'package:flutter/material.dart';
import 'package:flutter_journal_app/l10n/l10n_gen/app_localizations.dart';
import 'package:flutter_journal_app/src/app/app.dart';
import 'package:flutter_journal_app/src/screens/screens.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class JournalApp extends StatefulWidget {
  const JournalApp({super.key});

  @override
  State<JournalApp> createState() => _JournalAppState();
}

class _JournalAppState extends State<JournalApp> {
  final _localizationsDelegates = <LocalizationsDelegate>[
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  final _supportedLocales = [
    const Locale('en', ''),
    const Locale('es', ''),
  ];

  late Injector _injector;

  @override
  initState() {
    super.initState();

    _injector = DefaultInjector();
    _injector.initialize();
  }

  Widget _buildApp(
    BuildContext context, {
    required bool initialized,
  }) =>
      MaterialApp(
        // darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: !initialized ? const LoadingScreen() : null,
        localizationsDelegates: _localizationsDelegates,
        onGenerateRoute: initialized ? AppRouter.generatedRoutes : null,
        supportedLocales: _supportedLocales,
        // theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: _injector.initialized,
      stream: _injector.initializationStream,
      builder: (context, snapshot) {
        Widget result;

        if (snapshot.data == true) {
          result = Provider<EntryController>.value(
            value: _injector.entryController,
            child: _buildApp(
              context,
              initialized: snapshot.data!,
            ),
          );
        } else {
          result = _buildApp(
            context,
            initialized: snapshot.data!,
          );
        }

        return result;
      },
    );
  }
}
