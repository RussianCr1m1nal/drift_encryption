import 'package:drift/drift.dart';
import 'package:encryption_drift/data/database/database.dart';
import 'package:encryption_drift/domain/di/di.dart';
import 'package:faker/faker.dart';

List<PersonCompanion> generatePersonList() {
  Faker faker = Faker();
  List<PersonCompanion> list = [];

  for (int i = 0; i < 10000; i++) {
    list.add(PersonCompanion(
      id: Value(i),
      name: Value(faker.person.name()),
      dateOfBirth: Value(faker.date.dateTime(minYear: 1990, maxYear: 2005)),
    ));
  }

  return list;
}

class InsertBenchmark {
  InsertBenchmark();

  static Future<void> run() async {
    final watch = Stopwatch();
    final database = getIt<AppDataBase>();

    final list = generatePersonList();

    watch.start();
    await database.personDao.insertAll(list);
    print('Insert time for 10k row ${watch.elapsedMilliseconds}ms');
    watch.stop();
  }
}
