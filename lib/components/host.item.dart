import 'package:flutter/material.dart';

enum _PopupMenuItemType {delete}

enum HostItemStatus {error, good, unknown}

class HostItem extends StatelessWidget {
  HostItem({
    Key key,
    this.name,
    @required this.id,
    @required this.host,
    @required this.port,
    @required this.status,
    @required this.onDelete
  }) : super(key: key);

  final String id;
  final String name;
  final String host;
  final String port;
  final HostItemStatus status;
  final void Function(String id) onDelete;

  _getStatus(BuildContext context, HostItemStatus status) {
    switch(status) {
      case HostItemStatus.good: {
        return Icon(
          Icons.check_circle,
          color: Colors.lightGreen,
        );
      }
      break;

      case HostItemStatus.error: {
        return Icon(
          Icons.error,
          color: Theme.of(context).errorColor,
        );
      }
      break;

      default: {
        return Icon(
          Icons.sync,
          color: Colors.yellow,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final address = '$host:$port';
    final actualName = name != null ? name : address;
    final onDelete = () => this.onDelete(id);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Theme.of(context).colorScheme.surface),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        boxShadow: [
          new BoxShadow(
              color: Colors.black26,
              offset: new Offset(1.5, 1.5),
              blurRadius: 2.0,
          )
        ],

      ),
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 5,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                              actualName,
                              style: Theme.of(context).textTheme.title
                          ),
                          if (name != null) Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(address),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: _getStatus(context, status)
                    )
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: PopupMenuButton<_PopupMenuItemType>(
              onSelected: (typ) {
                switch (typ) {
                  case _PopupMenuItemType.delete: {
                    onDelete();
                  }
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<_PopupMenuItemType>>[
                PopupMenuItem<_PopupMenuItemType>(
                  value: _PopupMenuItemType.delete,
                  child: Text('Delete'),   
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
