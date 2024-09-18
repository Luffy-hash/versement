class Depot {
  final int id;
  final DateTime date;
  final int mount;

  Depot({required this.id, required this.date, required this.mount});

  factory Depot.fromJson(Map<String, dynamic> json) {
    return Depot(
        id: json['id'],
        date: DateTime.parse(json['date']),
        mount: json['montant']);
  }
}
