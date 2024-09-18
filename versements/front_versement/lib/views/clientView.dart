import 'package:flutter/material.dart';
import 'package:front_versement/models/client.dart';
import 'package:front_versement/services/apiClientService.dart';
import 'package:front_versement/views/singleViewClient.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  // declarer notre liste Clients
  late Future<List<Client>> clients;

  @override
  void initState() {
    super.initState();
    clients = ApiClientService().myClients();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
          future: clients,
          builder: (context, snapshot) {
            // si j'ai des données dans ma liste de client
            if (snapshot.hasData) {
              List<Client>? mesClients = snapshot.data;
              return ListView.builder(
                  itemCount: mesClients?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "${mesClients![index].name} ${mesClients[index].firstName} "),
                      subtitle: Text(mesClients[index].email),
                      leading: Image.network(
                          "https://as1.ftcdn.net/v2/jpg/05/66/32/22/1000_F_566322234_dSK1t1yBKcBP3TWJOD4qTDKVnDjkjJo4.jpg"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleViewClient(
                                    email: mesClients[index].email)));
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text("J'ai pas trouvé de client!",
                      style: TextStyle(fontSize: 18)));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
