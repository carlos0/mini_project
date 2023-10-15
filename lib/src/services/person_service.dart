import 'package:mini_proyect/src/model/persona.dart';
import 'package:mini_proyect/src/services/repository.dart';

class PersonService {
  late Repository _repository;
  PersonService() {
    _repository = Repository();
  }

  savePersona(Persona persona) async {
    return await _repository.insert('persona', persona.toMap());
  }

  // read all persons

  readAllPersons() async {
    return await _repository.getPerson('persona');
  }

  readAllPersonsNotSend() async {
    return await _repository.getPersonNotSend('persona');
  }

  updatePerson(Persona persona) async {
    return await _repository.update('persona', persona.toMap());
  }

  updateMultiplePerson(List<Persona> persona) async {
    var personMap = persona.map((e) {
      return e.idPersona;
    });
    return await _repository.multipleUpdate('persona', personMap);
  }

  deletePerson(idPersona) async {
    return await _repository.delete('persona', idPersona);
  }
}
