import 'dart:ffi';

class Client {
  // defini nos champs qui sont requis tous.
  final int id;
  final String name;
  final String firstName;
  final String phone;
  final String email;
  final String jobs;

  // on construit le client
  Client(
      {required this.id,
      required this.name,
      required this.firstName,
      required this.phone,
      required this.email,
      required this.jobs});

  // mapper du json => renvoyer du json
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        id: json['id'],
        name: json['name'],
        firstName: json['firstName'],
        phone: json['phone'],
        email: json['email'],
        jobs: json['jobs']);
  }

  // envoyer du json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstName': firstName,
      'phone': phone,
      'email': email,
      'jobs': jobs
    };
  }
}
