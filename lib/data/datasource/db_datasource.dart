import 'package:encryption_drift/data/database/database.dart';

abstract class DBDatasource {
  Future<void> updatePerson();
  Stream<List<PersonData>> watchPerson();
}
