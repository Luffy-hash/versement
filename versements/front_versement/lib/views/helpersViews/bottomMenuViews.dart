import 'package:flutter/material.dart';

class BottomMenuView extends StatelessWidget {
  const BottomMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: 'Client',
          icon: Icon(Icons.list_alt_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Versements',
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
            label: 'Profil', icon: Icon(Icons.person_3_outlined))
      ],
    );
  }
}
