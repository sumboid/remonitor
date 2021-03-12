import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:remonitor/l10n/messages_all.dart';

class Locales {
  Locales(this.localeName);

  static Future<Locales> load(Locale locale) {
    final String localeName = Intl.canonicalizedLocale(locale.languageCode);
    return initializeMessages(localeName).then((_) {
      return Locales(localeName);
    });
  }

  static Locales of(BuildContext context) {
    return Localizations.of<Locales>(context, Locales);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Remonitor',
      name: 'title',
      locale: localeName
    );
  }

  String get hosts {
    return Intl.message(
      'Hosts',
      name: 'hosts',
      locale: localeName,
    );
  }

  String get addNew {
    return Intl.message(
      'Add new',
      name: 'addNew',
      locale: localeName,
    );
  }

  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      locale: localeName,
    );
  }

  String get host {
    return Intl.message(
      'Host',
      name: 'host',
      locale: localeName,
    );
  }

  String get hostRequired {
    return Intl.message(
        'Host is required',
        name: 'hostRequired'
    );
  }

  String get port {
    return Intl.message(
      'Port',
      name: 'port',
      locale: localeName,
    );
  }

  String get portRequired {
    return Intl.message(
      'Port is required',
      name: 'portRequired'
    );
  }

  String get portRestriction {
    return Intl.message(
      'Port must be 1-65535',
      name: 'portRestriction',
      locale: localeName,
    );
  }
}

class LocalesDelegate extends LocalizationsDelegate<Locales> {
  const LocalesDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<Locales> load(Locale locale) {
    return Locales.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Locales> old) {
    return false;
  }
}