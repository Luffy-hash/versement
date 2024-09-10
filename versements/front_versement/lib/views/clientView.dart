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
                      title: Text(mesClients![index].name),
                      subtitle: Text(mesClients[index].email),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleViewClient(
                                      email: mesClients[index].email)));
                        },
                        child: const Text("voir plus"),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
