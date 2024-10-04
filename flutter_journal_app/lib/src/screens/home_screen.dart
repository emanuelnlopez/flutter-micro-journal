import 'package:flutter/material.dart';
import 'package:flutter_journal_app/l10n/l10n_gen/app_localizations.dart';
import 'package:flutter_journal_app/src/widgets/widgets.dart';
import 'package:flutter_journal_presentation/flutter_journal_presentation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final EntryController _controller;
  late final ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = context.read<EntryController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.app_name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StreamBuilder<List<PresentationEntry>>(
                stream: _controller.entriesStream,
                builder: (context, snapshot) {
                  Widget result;
                  if (snapshot.hasError) {
                    result = Center(child: Text(snapshot.error!.toString()));
                  } else if (snapshot.hasData) {
                    final entries = snapshot.data!;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                      );
                    });

                    result = ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (context, index) => EntryListItem(
                        entry: entries[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        endIndent: 8.0,
                        height: 1.0,
                        indent: 8.0,
                        thickness: 1.0,
                      ),
                      itemCount: entries.length,
                    );
                  } else {
                    result = const CircularProgressIndicator();
                  }
                  return Expanded(child: result);
                },
              ),
              const EntryInputForm(),
            ],
          ),
        ));
  }
}
