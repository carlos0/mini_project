import 'package:mini_proyect/src/services/db_sqltite.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;

  Future<Database?> get database async =>
      _database ??= await _databaseConnection.setDatabase();

  // Insert Person
  insert(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  // Read all records
  getPerson(table) async {
    var connection = await database;
    return await connection?.query(table, orderBy: "idPersona DESC");
  }

  // Read a Single Person

  getPersonId(table, id) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'idPersona=?', whereArgs: [id]);
  }

  // Read a Single Person

  getPersonNotSend(table) async {
    var connection = await database;
    return await connection?.query(table, where: 'enviado=0');
  }

  // Update Person

  update(table, data) async {
    var connection = await database;
    return await connection?.update(table, data,
        where: 'idPersona=?', whereArgs: [data['idPersona']]);
  }

  //

  multipleUpdate(table, data) async {
    var connection = await database;
    return await connection
        ?.rawUpdate('UPDATE persona SET enviado = 1 WHERE idPersona in $data');
  }

  // delete person

  delete(table, id) async {
    var connection = await database;
    return await connection
        ?.rawDelete("delete from $table where idPersona=$id");
  }
}
