import 'package:postgres/postgres.dart';

class DatabaseService {
  final _connection = Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'cube',
      username: 'chiyu',
      password: '123',
    ),
    settings: const ConnectionSettings(
      sslMode: SslMode.disable,
    ),
  );



}
