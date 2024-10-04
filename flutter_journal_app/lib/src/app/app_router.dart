import 'package:flutter/material.dart';
import 'package:flutter_journal_app/src/app/app.dart';
import 'package:flutter_journal_app/src/screens/screens.dart';

abstract class AppRouter {
  static RouteFactory get generatedRoutes => (RouteSettings settings) {
        ModalRoute? route;
        final argumentsMap = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case NamedRoute.home:
            route = MaterialPageRoute(
              builder: (_) => const HomeScreen(),
              settings: RouteSettings(name: settings.name),
            );
            break;
          case NamedRoute.edit:
            route = MaterialPageRoute(
              builder: (_) => EditEntryScreen(entry: argumentsMap?['entry']),
              settings: RouteSettings(name: settings.name),
            );
            break;
        }

        return route;
      };
}
