import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:front_versement/views/clientView.dart';
import 'package:front_versement/views/helpersViews/bottomMenuViews.dart';
import 'package:front_versement/views/user/registerForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterForm(), // const MyHomePage(title: 'App Name'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ma logique

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        title: Text(widget.title),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search_sharp),
          )
        ],
      ),
      subHeader: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          "Mes clients",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      backLayer: Container(color: Colors.greenAccent),
      frontLayer: Container(
        color: Colors.white70,
        child: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: ClientView()),
          ],
        )),
      ),
      bottomNavigationBar: const BottomMenuView(),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
