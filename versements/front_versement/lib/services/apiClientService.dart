import 'dart:convert';

import 'package:front_versement/models/client.dart';
import 'package:http/http.dart' as http;

class ApiClientService {
  final String baseUrl = "http://localhost:8080/api/versements";

  // Renvoie tous mes clients inscrit
  Future<List<Client>> myClients() async {
    // parser l'url pour se connecter à l'api
    final response = await http.get(Uri.parse(baseUrl));

    // si tout est bon code 200 on renvoie la listes des clients
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Client> clients =
          body.map((dynamic item) => Client.fromJson(item)).toList();

      return clients;
    }
    // sinon on leve l'exception
    else {
      throw Exception("pas de clients trouvé!");
    }
  }
}
