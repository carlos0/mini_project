import 'package:mini_proyect/src/screens/data_screen.dart';
import 'package:mini_proyect/src/screens/map_screen.dart';
import 'package:mini_proyect/src/screens/person_crud_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPage = 0;
  final drawerItems = [
    DrawerItem("Inicio", Icons.home),
    DrawerItem("Registro de Personas", Icons.person),
    DrawerItem("Mapa y GPS", Icons.map)
  ];

  Widget getDrawerItemWidget(position) {
    switch (position) {
      case 0:
        return const DataScreen();
      case 1:
        return const PersonCrudScreen();
      default:
        return const MapScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: getDrawerItemWidget(selectedPage),
      drawer: Drawer(
        child: Column(
          children: [cabecera(), cuerpo()],
        ),
      ),
    );
  }

  Widget cabecera() {
    return UserAccountsDrawerHeader(
      accountName: const Text(
        "Carlos Macuchapi",
        style: TextStyle(color: Colors.white),
      ),
      accountEmail: const Text("cmacuchapi@example.com   -   Registrador",
          style: TextStyle(color: Colors.white)),
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 34,
            backgroundImage: const Image(
              image: AssetImage(
                "assets/images/profile1.jpeg",
              ),
            ).image,
          ),
        ),
        onTap: () {},
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            //Color(0xFFFFEBEE),
            Color(0xFFa2221e),
            Color(0xffa2221e),
          ])),
    );
  }

  Widget cuerpo() {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      drawerOptions.add(ListTile(
        title: Text(drawerItems[i].title),
        leading: Icon(drawerItems[i].icon),
        trailing: const Icon(Icons.arrow_right),
        selected: i == selectedPage,
        onTap: () {
          setState(() {
            selectedPage = i;
            Navigator.of(context).pop();
          });
        },
      ));
    }
    return Column(
      children: drawerOptions,
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}
