import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remonitor/components/host.item.dart';
import 'package:remonitor/models/host.model.dart';
import 'package:remonitor/state/host.list.dart';
import 'package:remonitor/locales.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hostListProvider = Provider.of<HostList>(context);
    final onDelete = (String id) => Provider.of<HostList>(context, listen: false).delete(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.of(context).hosts),
      ),
      body: Scrollbar(
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 56, top: 10),
            itemCount: hostListProvider.hosts.length,
            itemBuilder: (BuildContext context, int index) {
              final pad = (Widget w) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: w
              );
              final host = hostListProvider.hosts[index];
              final getStatus = (HostStatus status) {
                switch(status) {
                  case HostStatus.good: {
                    return HostItemStatus.good;
                  }
                  break;

                  case HostStatus.error: {
                    return HostItemStatus.error;
                  }
                  break;

                  default: {
                    return HostItemStatus.unknown;
                  }
                }
              };

              return pad(
                  HostItem(
                    id: host.id,
                    name: host.name,
                    host: host.host,
                    port: host.port,
                    status: getStatus(host.status),
                    onDelete: onDelete,
                  )
              );
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
