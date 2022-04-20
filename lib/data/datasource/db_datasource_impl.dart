import 'package:encryption_drift/data/database/database.dart';
import 'package:encryption_drift/data/datasource/db_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:faker/faker.dart';

@Singleton(as: DBDatasource)
class DBDatasourceImpl extends DBDatasource {
  final AppDataBase dataBase;

  DBDatasourceImpl({required this.dataBase});

  @override
  Future<void> updatePerson() async {
    Faker faker = Faker();

    for (int i = 0; i < 100; i++) {
      dataBase.personDao.updatePerson(
        i,
        faker.person.name(),
        faker.date.dateTime(minYear: 1990, maxYear: 2005),
      );
    }
  }

  @override
  Stream<List<PersonData>> watchPerson() {
    return dataBase.personDao.watchPerson();
  }
}
