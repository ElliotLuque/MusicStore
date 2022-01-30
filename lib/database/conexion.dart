import 'package:postgres/postgres.dart';

class Conexion {
  static const String ip = "192.168.56.1";
  static const String database = "music_store";
  static const String user = "postgres";
  static const String pass = "postgres";

  static var connection =
      PostgreSQLConnection(ip, 5432, database, username: user, password: pass);

  Future<void> conectar() async {
    await connection.open();
    print("Conectado!");
  }
}
