import 'package:postgres/postgres.dart';

class Conexion {
  static const String ip =
      "music-store.cc6sun7j5vk5.eu-west-2.rds.amazonaws.com";
  static const String database = "music_store";
  static const String user = "postgres";
  static const String pass = "postgres";

  static var connection =
      PostgreSQLConnection(ip, 5432, database, username: user, password: pass);

  Future<void> conectar() async {
    await connection.open();
  }
}
