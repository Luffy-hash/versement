import 'dart:convert';

import 'package:front_versement/models/client.dart';
import 'package:front_versement/models/depot.dart';
import 'package:http/http.dart' as http;

class ApiClientService {
  final String baseUrl = "http://10.245.96.4:8584/api/versement/client";

  // Renvoie tous mes clients inscrit
  Future<List<Client>> myClients() async {
    try {
      // parser l'url pour se connecter à l'api
      final response = await http.get(Uri.parse("$baseUrl/mes-clients"));

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
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // fonction qui permet d'afficher les infos d'un client
  Future<Client> singleClient(String email) async {
    try {
      // parser l'url pour se connecter à l'api
      final response = await http.get(Uri.parse("$baseUrl/$email"));

      // // si tout est bon code 200 on renvoie les informations du client
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        Client myClient = Client.fromJson(body);
        return myClient;
      }
      // sinon on leve l'exception
      else {
        throw Exception("pas de client trouvé");
      }
    } catch (e) {
      throw Exception("Erreur json");
    }
  }

  // liste de tous mes versement d'un client
  Future<List<Depot>> getDepotListForClient(String emailClient) async {
    try {
      // parser l'url de l'api
      final response =
          await http.get(Uri.parse("$baseUrl/$emailClient/versements"));
      // print(response.body);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Depot.fromJson(item)).toList();
      } else {
        throw Exception("Pas de versement.");
      }
    } catch (e) {
      throw Exception(" ${e.toString()} ");
    }
  }
}
