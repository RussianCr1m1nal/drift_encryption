import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:encryption_drift/data/database/table/table.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'database.g.dart';

bool _debugCheckHasCipher(database) {
  return database.select('PRAGMA cipher_version;').isNotEmpty;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final folder = await getApplicationDocumentsDirectory();
    final file = File(path.join(folder.path, 'database.sqlite'));
    return NativeDatabase(file, setup: (rawDb) {
      assert(_debugCheckHasCipher(rawDb));
      rawDb.execute("PRAGMA key = 'passphrase';");
    });
  });
}

@DriftDatabase(tables: [Person], daos: [PersonDao])
@Singleton()
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [Person])
class PersonDao extends DatabaseAccessor<AppDataBase> with _$PersonDaoMixin {
  final AppDataBase dataBase;

  PersonDao(this.dataBase) : super(dataBase);

  Stream<List<PersonData>> watchPerson() {
    return select(person).watch();
  }

  Future<void> updatePerson(int id, String name, DateTime dateOfBirth) async {
    into(person).insert(
        PersonCompanion(
          id: Value(id),
          name: Value(name),
          dateOfBirth: Value(dateOfBirth),
        ),
        mode: InsertMode.insertOrReplace);
  }

  Future<void> insertAll(List<PersonCompanion> personList) async {

    await batch((batch) {      
      batch.insertAll(person, personList);
    });


    // for (PersonCompanion _person in personList) {
    //   await into(person).insert(_person, mode: InsertMode.insertOrReplace);
    // }
  }

  Future<void> selectAll() async {
    final list = await select(person).get();
    // print('items selected: ${list.length}');
  }

  Future<void> deleteAll() async {
    int deleted = await delete(person).go();
    // print('items deleted: $deleted');
  }

  Future<void> updateAll(List<PersonCompanion> personList) async {
    for (PersonCompanion _person in personList) {
      update(person).replace(_person);
    }
  }
}
