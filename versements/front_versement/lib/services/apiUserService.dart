import 'dart:convert';

import 'package:front_versement/models/user.dart';
import 'package:http/http.dart' as http;

class ApiUserService {
  final String basicUrl = "http://10.245.96.4:8584/api/versement";
  final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  //Inscrire un utilisateur
  Future<void> postUser(Utilisateur user) async {
    try {
      final response = await http.post(Uri.parse("$basicUrl/registration"),
          headers: headers,
          body: jsonEncode({
            "email": user.email,
            "mdp": user.mdp,
          }));

      if (response.statusCode == 201) {
        print("ok tout est bon");
      } else {
        throw Exception("Cet utilisateur existe déjà !");
      }
    } catch (e) {
      throw Exception("erreur json");
    }
  }

  // Connexion d'un Utilisateur
  Future<bool> getUser(Utilisateur user) async {
    try {
      final response = await http.get(
          Uri.parse("$basicUrl/login?email=${user.email}&mdp=${user.mdp}"),
          headers: headers);
      if (response.statusCode == 200) {
        bool body = jsonDecode(response.body);
        return body;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("erreur json ${e.toString()}");
    }
  }
}
