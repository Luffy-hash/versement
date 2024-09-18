import 'package:flutter/material.dart';
import 'package:front_versement/models/depot.dart';
import 'package:front_versement/services/apiClientService.dart';
import 'package:intl/intl.dart';

class MyDepotListForCustumer extends StatefulWidget {
  final String email;
  const MyDepotListForCustumer({super.key, required this.email});

  @override
  State<MyDepotListForCustumer> createState() => _MyDepotListForCustumerState();
}

class _MyDepotListForCustumerState extends State<MyDepotListForCustumer> {
  late Future<List<Depot>> listOfDepot;

  @override
  void initState() {
    // listOfDepot = ApiClientService().getDepotListForClient(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiClientService()
            .getDepotListForClient(widget.email), //listOfDepot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Depot> myDepotList = snapshot.data!;
            print(myDepotList);
            return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(DateFormat('dd-MM-yyyy')
                        .format(myDepotList[index].date)),
                    subtitle: Text(myDepotList[index].mount.toString()),
                    leading: const Icon(Icons.label),
                  );
                },
                itemCount: myDepotList.length);
          } else if (snapshot.hasError) {
            return const Text("pas de versement trouver");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
