import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'DBpersona');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE persona (idPersona INTEGER PRIMARY KEY, cedulaIdentidad TEXT, nombres TEXT, apellidos TEXT, celular INTEGER, fechaNacimiento TEXT, enviado INTEGER)";
    await database.execute(sql);
  }
}
