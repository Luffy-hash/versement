import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:front_versement/models/client.dart';
import 'package:front_versement/services/apiClientService.dart';
import 'package:front_versement/views/helpersViews/bottomMenuViews.dart';
import 'package:front_versement/views/myDepotListForCustumer.dart';
import 'package:front_versement/views/myDepotListForCustumerMounth.dart';

class SingleViewClient extends StatefulWidget {
  final String email;
  const SingleViewClient({super.key, required this.email});

  @override
  State<SingleViewClient> createState() => _SingleViewClientState();
}

class _SingleViewClientState extends State<SingleViewClient>
    with SingleTickerProviderStateMixin {
  late Future<Client> futureClient;
  late List<Client> filteredClientsList = [];

  @override
  void initState() {
    futureClient = ApiClientService().singleClient(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BackdropScaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Text("Depôt"),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search_sharp),
            )
          ],
          bottom: const TabBar(indicatorColor: Colors.grey, tabs: [
            Tab(text: 'Mois en cours'),
            Tab(text: 'Historiques'),
          ]),
        ),
        backLayer: Container(color: Colors.greenAccent),
        frontLayer: SizedBox(
            child: FutureBuilder<Client>(
                future: futureClient,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("J'ai pas trouvé de depôt !"));
                  } else if (snapshot.hasData) {
                    return TabBarView(
                      children: <Widget>[
                        SizedBox(
                            child: Center(
                                child: MyDepotListForCustumerMounth(
                                    email: widget.email))),
                        SizedBox(
                            child: SizedBox(
                          child: MyDepotListForCustumer(email: widget.email),
                        )),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text("Pas de client trouvé",
                            style: TextStyle(fontSize: 18)));
                  }
                })),
        bottomNavigationBar: const BottomMenuView(),
      ),
    );
  }
}
