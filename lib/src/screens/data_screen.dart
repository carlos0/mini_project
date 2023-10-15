import 'dart:convert';

import 'package:mini_proyect/src/model/persona.dart';
import 'package:mini_proyect/src/screens/sub_screens/view_person.dart';
import 'package:mini_proyect/src/services/person_service.dart';
import 'package:mini_proyect/src/services/server_api.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

var connection = false;

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late List<Persona> _personList = [];
  final _personaService = PersonService();
  final _server = ServerAPi();
  getAllPersons() async {
    var personas = await _personaService.readAllPersonsNotSend();
    _personList = <Persona>[];
    personas.forEach((persona) {
      setState(() {
        var personaModel = Persona();
        personaModel.idPersona = persona['idPersona'];
        personaModel.cedulaIdentidad = persona['cedulaIdentidad'];
        personaModel.nombres = persona['nombres'];
        personaModel.apellidos = persona['apellidos'];
        personaModel.celular = persona['celular'];
        personaModel.fechaNacimiento = persona['fechaNacimiento'];
        personaModel.enviado = persona['enviado'];

        _personList.add(personaModel);
      });
    });
  }

  @override
  void initState() {
    getAllPersons();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.greenAccent,
    ));
  }

  _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<ConnectivityResult>(
              stream: connectivity.onConnectivityChanged,
              builder: (_, snapshot) {
                return InternetConnectionWidget(
                    snapshot: snapshot, widget: Container());
              }),
          const Text(
            "Registros a subir a Servidor:",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFa2221e),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _personList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPerson(
                                    persona: _personList[index],
                                  )));
                    },
                    leading: const Icon(Icons.person),
                    title: Text(
                        "${_personList[index].nombres ?? ''} ${_personList[index].apellidos ?? ''}"),
                    subtitle: Text(
                        "C.I.: ${_personList[index].cedulaIdentidad ?? ''} - ${_personList[index].fechaNacimiento ?? ''}\nCel.: ${_personList[index].celular ?? ''}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              color: Color(0xff17324f),
                            ))
                      ],
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: connection
                  ? () async {
                      var result = await _server.pullDataPerson(_personList);
                      var resPerson = jsonDecode(result.body);
                      if (resPerson['success']) {
                        await _personaService.updateMultiplePerson(_personList);
                        getAllPersons();
                        _showSuccessSnackBar('Datos enviados Correctamente.');
                      } else {
                        _showErrorSnackBar('Ocurrio un error.');
                      }
                    }
                  : null,
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
              child: Text(connection
                  ? 'Enviar a Servidor los registros'
                  : 'Sin conexion')),
        ],
      ),
    ));
  }
}

class InternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;
  const InternetConnectionWidget(
      {Key? key, required this.snapshot, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        connection = false;
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.all(10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "No tiene conexión a Internet",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ));
          default:
            connection = true;
            return widget;
        }
      default:
        connection = false;
        return Container(
            color: Colors.redAccent,
            padding: const EdgeInsets.all(10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "No tiene conexión a Internet",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                )
              ],
            ));
    }
  }
}
