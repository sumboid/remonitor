import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:remonitor/locales.dart';
import 'package:remonitor/state/host.list.dart';
import 'package:remonitor/pages/list.page.dart';
import 'package:remonitor/pages/add.new.page.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HostList())],
      child: MaterialApp(
        localizationsDelegates: [
          const LocalesDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('en', ''), const Locale('ru', '')],
        initialRoute: '/',
        routes: {
          '/': (context) => ListPage(),
          '/add': (context) => AddNewPage(),
        },
        onGenerateTitle: (BuildContext context) =>
          Locales.of(context).title,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.purple,
        ),
      ),
    );
  }
}
