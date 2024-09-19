import 'dart:convert';

import 'package:backdrop/backdrop.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:front_versement/main.dart';
import 'package:front_versement/models/user.dart';
import 'package:front_versement/services/apiUserService.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // controller des champs de saisies
  final emailController = TextEditingController();
  final mdpController = TextEditingController();
  final confirmMdpController = TextEditingController();

  // choix
  bool isRegister = false;

  // info
  String information = "";

  // liberer la ressource
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    mdpController.dispose();
    confirmMdpController.dispose();
  }

  // vider les champs de textes
  void clearTextField() {
    mdpController.clear();
    confirmMdpController.clear();
  }

  // crypter le mot de passe
  String hashPassword(String password) {
    // Convertir le mot de passe en bytes
    var bytes = utf8.encode(password);

    // Créer un hachage SHA-256
    var digest = sha256.convert(bytes);

    // Retourner le mot de passe haché en hexadécimal
    return digest.toString();
  }

  void changeMsg(String msg) {
    setState(() {
      information = msg;
    });
  }

  bool textFieldIsNotEmpty() {
    final email = emailController.text.trim();
    final mdp = mdpController.text.trim();
    return email.isEmpty || mdp.isEmpty;
  }

  bool isValidEmail(String email) {
    final regexEmail =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regexEmail.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        title: Text(isRegister ? "Inscription" : "Connexion"),
        centerTitle: true,
      ),
      backLayer: Container(
        color: Colors.greenAccent,
      ),
      frontLayer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(information),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'email',
              ),
            ),
            TextFormField(
              controller: mdpController,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'mot de passe',
              ),
            ),
            isRegister
                ? TextFormField(
                    controller: confirmMdpController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'confirmer votre mot de passe',
                    ),
                  )
                : const SizedBox(),
            ElevatedButton(
                onPressed: () async {
                  // recuperation des champs + hashage
                  final email = emailController.text.trim();
                  final mdp = hashPassword(mdpController.text.trim());
                  final confirmMdp =
                      hashPassword(confirmMdpController.text.trim());
                  // verification des texte vide et autres
                  if (textFieldIsNotEmpty()) {
                    changeMsg("Ce champs est requis");
                    return;
                  }
                  // varification du mail
                  if (!isValidEmail(email)) {
                    changeMsg("format de l'email invalide :)");
                    return;
                  }
                  // creation d'un User
                  final registerUtilisateur =
                      Utilisateur(email: email, mdp: mdp);

                  // page d'inscription
                  if (isRegister) {
                    if (mdp == confirmMdp) {
                      clearTextField();
                      // faire la requete
                      try {
                        await ApiUserService().postUser(registerUtilisateur);
                        setState(() {
                          isRegister = false;
                        });
                        emailController.clear();
                        changeMsg("vous etes inscrit");
                        // vider les champs de textes
                      } catch (e) {
                        //probleme lors de la requette
                        changeMsg("email existant");
                      }
                    } else {
                      // mot de passe different a gerer
                      changeMsg("mot de passe different");
                      clearTextField();
                    }
                  }
                  // page de connexion
                  else {
                    final result =
                        await ApiUserService().getUser(registerUtilisateur);
                    if (result) {
                      emailController.clear();
                      clearTextField();
                      changeMsg("connecté");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const MyHomePage(title: 'App Name'))),
                        (Route<dynamic> route) => false,
                      );

                      changeMsg("Identifiant ou mot de passe incorrect :(");
                      clearTextField();
                    }
                  }
                },
                child: Text(isRegister ? "Enregistrer" : "Connexion")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isRegister
                    ? "j'ai deja un compte ?"
                    : "Je n'ai pas d compte ?"),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isRegister = !isRegister;
                      });
                    },
                    child: Text(isRegister ? "Se connecter" : "S'inscrire"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
