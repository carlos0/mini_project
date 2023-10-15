import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerAPi {
  String baseUrl = 'http://localhost:3000/api/v1';

  pullDataPerson(data) async {
    var personMap = data.map((e) {
      return {
        "cedula_identidad": e.cedulaIdentidad,
        "nombres": e.nombres,
        "apellidos": e.apellidos,
        "celular": e.celular,
        "fecha_nacimiento": e.fechaNacimiento,
      };
    }).toList(); //convert to map
    String stringPersons = json.encode(personMap);
    var url = Uri.http("10.16.0.226:3000", "/api/v1/persona/multi");
    return await http.post(
      url,
      body: stringPersons,
      headers: {"Content-Type": "application/json"},
    );
  }
}
