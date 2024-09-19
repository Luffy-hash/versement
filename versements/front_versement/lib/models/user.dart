class Utilisateur {
  int? id;
  final String email;
  final String mdp;

  Utilisateur({required this.email, required this.mdp});

  factory Utilisateur.FromJson(Map<String, dynamic> williame) {
    return Utilisateur(email: williame['email'], mdp: williame['mdp']);
  }
}
