import 'package:flutter/material.dart';
import 'package:front_versement/models/client.dart';
import 'package:front_versement/models/depot.dart';
import 'package:front_versement/services/apiClientService.dart';
import 'package:front_versement/views/myDepotListForCustumer.dart';

class SingleViewClient extends StatefulWidget {
  final String email;
  const SingleViewClient({super.key, required this.email});

  @override
  State<SingleViewClient> createState() => _SingleViewClientState();
}

class _SingleViewClientState extends State<SingleViewClient>
    with SingleTickerProviderStateMixin {
  late Future<Client> futureClient;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    futureClient = ApiClientService().singleClient(widget.email);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Text("Front_versement"),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.menu),
            )
          ],
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.grey,
              tabs: const [
                Tab(text: 'Mois en cours'),
                Tab(text: 'Historiques')
              ]),
        ),
        body: SizedBox(
            child: FutureBuilder<Client>(
                future: futureClient,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16, child: Text(snapshot.data!.name)),
                        const Text(
                          "Mes versements",
                          textAlign: TextAlign.left,
                        ),
                        const Divider(color: Colors.black12),
                        Expanded(
                          child:
                              TabBarView(controller: _tabController, children: [
                            SizedBox(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [],
                            )),
                            SizedBox(
                              child:
                                  MyDepotListForCustumer(email: widget.email),
                            ),
                          ]),
                        )
                      ],
                    );
                  } else {
                    return const Text("Pas de client trouvé");
                  }
                })));
  }
}
