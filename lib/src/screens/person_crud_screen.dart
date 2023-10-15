import 'package:mini_proyect/src/screens/sub_screens/create_person.dart';
import 'package:mini_proyect/src/model/persona.dart';
import 'package:mini_proyect/src/screens/sub_screens/edit_person.dart';
import 'package:mini_proyect/src/screens/sub_screens/view_person.dart';
import 'package:mini_proyect/src/services/person_service.dart';
import 'package:flutter/material.dart';

class PersonCrudScreen extends StatefulWidget {
  const PersonCrudScreen({super.key});

  @override
  State<PersonCrudScreen> createState() => _PersonCrudScreenState();
}

class _PersonCrudScreenState extends State<PersonCrudScreen> {
  late List<Persona> _personList = [];
  final _personaService = PersonService();
  getAllPersons() async {
    var personas = await _personaService.readAllPersons();
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

  _deletedFormDialog(BuildContext context, idPersona) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Estas Seguro de eliminar?',
              style: TextStyle(color: Color(0xff17324f), fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent),
                  onPressed: () async {
                    var result = await _personaService.deletePerson(idPersona);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllPersons();
                      _showSuccessSnackBar(
                          'Persona eliminada Satisfactoriamente.');
                    }
                  },
                  child: const Text('Eliminar')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff17324f)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePerson()))
              .then((data) {
            if (data != null) {
              getAllPersons();
              _showSuccessSnackBar('Persona Creada Satisfactoriamente.');
            }
          });
        },
        backgroundColor: const Color(0xff17324f),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget body() {
    return ListView.builder(
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
                  _personList[index].enviado == 1
                      ? const Text("")
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPerson(
                                          persona: _personList[index],
                                        ))).then((data) {
                              if (data != null) {
                                getAllPersons();
                                _showSuccessSnackBar(
                                    'Persona Creada Satisfactoriamente.');
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xff17324f),
                          )),
                  _personList[index].enviado == 1
                      ? const Text("")
                      : IconButton(
                          onPressed: () {
                            _deletedFormDialog(
                                context, _personList[index].idPersona);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Color(0xffa2221e),
                          ))
                ],
              ),
            ),
          );
        });
  }
}
