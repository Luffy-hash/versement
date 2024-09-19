import 'package:flutter/material.dart';
import 'package:front_versement/models/depot.dart';
import 'package:front_versement/services/apiClientService.dart';
import 'package:intl/intl.dart';

class MyDepotListForCustumerMounth extends StatefulWidget {
  final String email;
  const MyDepotListForCustumerMounth({super.key, required this.email});

  @override
  State<MyDepotListForCustumerMounth> createState() =>
      _MyDepotListForCustumerMounthState();
}

class _MyDepotListForCustumerMounthState
    extends State<MyDepotListForCustumerMounth> {
  late Future<List<Depot>> listDepotMonth;
  List<Depot> listFilterDepotMounth = [];
  @override
  void initState() {
    listDepotMonth = ApiClientService().getDepotListForClient(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listDepotMonth,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            listFilterDepotMounth = snapshot.data!
                .where((element) => element.date.month == DateTime.now().month)
                .toList();
            return ListView.builder(
                itemCount: listFilterDepotMounth.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                      "${listFilterDepotMounth[index].mount.toString()} euros",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(DateFormat('dd-MM-yyyy')
                        .format(listFilterDepotMounth[index].date)),
                    leading: const Icon(Icons.label),
                  );
                }));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Pas de versement trouvé :!"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
