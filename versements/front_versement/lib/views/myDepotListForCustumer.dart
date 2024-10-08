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
    listOfDepot = ApiClientService().getDepotListForClient(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listOfDepot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Depot> myDepotList = snapshot.data!;

            return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "${myDepotList[index].mount.toString()} euros",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(DateFormat('dd-MM-yyyy')
                        .format(myDepotList[index].date)),
                    leading: const Icon(Icons.label),
                  );
                },
                itemCount: myDepotList.length);
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              "J'ai pas trouvé de versement",
              style: TextStyle(fontSize: 18),
            ));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
