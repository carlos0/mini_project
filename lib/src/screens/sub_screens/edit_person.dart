import 'package:mini_proyect/src/model/persona.dart';
import 'package:mini_proyect/src/services/person_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class EditPerson extends StatefulWidget {
  final Persona persona;
  const EditPerson({Key? key, required this.persona}) : super(key: key);
  @override
  State<EditPerson> createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
  final _cedulaIdentidadController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _celularController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();

  bool _validateCedula = false;
  bool _validateNombres = false;
  bool _validateApellidos = false;
  bool _validateCelular = false;
  bool _validateFechaNac = false;

  final _personService = PersonService();

  @override
  void initState() {
    setState(() {
      _cedulaIdentidadController.text = widget.persona.cedulaIdentidad ?? '';
      _nombresController.text = widget.persona.nombres ?? '';
      _apellidosController.text = widget.persona.apellidos ?? '';
      _celularController.text = widget.persona.celular.toString();
      _fechaNacimientoController.text = widget.persona.fechaNacimiento ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form. Editar Persona"),
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar Persona',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff17324f),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _cedulaIdentidadController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Cédula de identidad",
                  labelText: "cedula",
                  errorText:
                      _validateCedula ? 'El valor no puede ser vacio.' : null),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _nombresController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Nombres",
                  labelText: "nombres",
                  errorText:
                      _validateNombres ? 'El valor no puede ser vacio.' : null),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _apellidosController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Apellidos",
                  labelText: "apellidos",
                  errorText: _validateApellidos
                      ? 'El valor no puede ser vacio.'
                      : null),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _celularController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Celular",
                  labelText: "celular",
                  errorText:
                      _validateCelular ? 'El valor no puede ser vacio.' : null),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _fechaNacimientoController,
              decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_today_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Fecha de nacimiento",
                  labelText: "fecha_nacimiento",
                  errorText: _validateFechaNac
                      ? 'El valor no puede ser vacio.'
                      : null),
              onTap: () async {
                DateTime? pickerdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1920),
                    lastDate: DateTime(2100));
                if (pickerdate != null) {
                  setState(() {
                    _fechaNacimientoController.text =
                        DateFormat('dd/MM/yyyy').format(pickerdate);
                  });
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff17324f)),
                    onPressed: () async {
                      setState(() {
                        _cedulaIdentidadController.text.isEmpty
                            ? _validateCedula = true
                            : _validateCedula = false;
                        _nombresController.text.isEmpty
                            ? _validateNombres = true
                            : _validateNombres = false;
                        _apellidosController.text.isEmpty
                            ? _validateApellidos = true
                            : _validateApellidos = false;
                        _celularController.text.isEmpty
                            ? _validateCelular = true
                            : _validateCelular = false;
                        _fechaNacimientoController.text.isEmpty
                            ? _validateFechaNac = true
                            : _validateFechaNac = false;
                      });
                      if (_validateCedula == false &&
                          _validateNombres == false &&
                          _validateApellidos == false &&
                          _validateCelular == false &&
                          _validateFechaNac == false) {
                        var persona = Persona();
                        persona.idPersona = widget.persona.idPersona;
                        persona.cedulaIdentidad =
                            _cedulaIdentidadController.text;
                        persona.nombres = _nombresController.text;
                        persona.apellidos = _apellidosController.text;
                        persona.celular = int.parse(_celularController.text);
                        persona.fechaNacimiento =
                            _fechaNacimientoController.text;
                        persona.enviado = 0;
                        var result = await _personService.updatePerson(persona);
                        Navigator.pop(context, result);
                      }
                    },
                    child: const Text(
                      "Editar Persona",
                      style: TextStyle(fontSize: 15),
                    )),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      _cedulaIdentidadController.text = '';
                      _nombresController.text = '';
                      _apellidosController.text = '';
                      _celularController.text = '';
                      _fechaNacimientoController.text = '';
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
