import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:remonitor/models/host.model.dart';
import 'package:remonitor/db.dart';

class HostList with ChangeNotifier {
  List<HostModel> _hosts = [];

  HostList() {
    _updateHosts();
  }

  UnmodifiableListView<HostModel> get hosts => UnmodifiableListView(_hosts);

  void add(HostModel h) => addHost(h).then((_) => _updateHosts());
  void delete(String id) => deleteHost(id).then((_) => _updateHosts());

  void _updateHosts() {
    getHosts().then((hosts) {
      _hosts = hosts;

      _hosts.forEach((h) => Socket
        .connect(h.host, int.parse(h.port))
        .then((s) {
          s.close();
          return HostStatus.good;
        })
        .catchError((_) => HostStatus.error)
        .then((s) {
          h.status = s;
          notifyListeners();
        })
      );

      notifyListeners();
    });
  }
}