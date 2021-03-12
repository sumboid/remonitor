import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:remonitor/models/host.model.dart';
import 'package:remonitor/state/host.list.dart';
import 'package:remonitor/locales.dart';

class AddNewPage extends StatefulWidget {
  @override
  _AddNewFormState createState() {
    return _AddNewFormState();
  }
}

class _AddNewFormState extends State<AddNewPage> {
  final _formKey = GlobalKey<FormState>();
  final _model = HostModel(id: Uuid().v4());

  @override
  Widget build(BuildContext context) {
    final hostListProvider = Provider.of<HostList>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.of(context).addNew),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: Locales.of(context).name,
                ),
                maxLength: 15,
                onChanged: (value) => setState(() => _model.name = value),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: Locales.of(context).host,
                ),
                onChanged: (value) => setState(() => _model.host = value),
                validator: (value) {
                  if (value.isEmpty) {
                    return Locales.of(context).hostRequired;
                  }

                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: Locales.of(context).port,
                ),
                onChanged: (value) => setState(() => _model.port = value),
                validator: (value) {
                  if (value.isEmpty) {
                    return Locales.of(context).portRequired;
                  }

                  try {
                    final num = int.parse(value);

                    if (num == null || num < 1 || num > 65535) {
                      return Locales.of(context).portRestriction;
                    }
                  } catch (_) {
                    return Locales.of(context).portRestriction;
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      hostListProvider.add(_model);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}