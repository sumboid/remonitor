enum HostStatus {good, error, unknown}

class HostModel {
  String id;
  String name;
  String host;
  String port;
  HostStatus status = HostStatus.unknown;

  HostModel({this.id, this.name, this.host, this.port, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'host': host,
      'port': port,
    };
  }
}