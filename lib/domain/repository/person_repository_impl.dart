import 'dart:async';

import 'package:encryption_drift/data/datasource/db_datasource.dart';
import 'package:encryption_drift/domain/entity/person.dart';
import 'package:encryption_drift/domain/repository/person_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: PersonRepository)
class PersonRepositoryImpl extends PersonRepository {
  final DBDatasource datasource;

  final BehaviorSubject<List<Person>> personSubject = BehaviorSubject<List<Person>>.seeded([]);
  StreamSubscription? personSubscription;

  PersonRepositoryImpl({required this.datasource});

  @override
  Stream<List<Person>> watchPerson() {
    personSubscription?.cancel();
    personSubscription = datasource
        .watchPerson()
        .map((list) => list
            .map((personData) => Person(
                  id: personData.id,
                  name: personData.name,
                  dateOfBirth: personData.dateOfBirth,
                ))
            .toList())
        .listen((personList) {
      personSubject.add(personList);
    });

    return personSubject.stream;
  }

  @override
  Future<void> updatePerson() async {
    datasource.updatePerson();
  }

  void dispose() {
    personSubscription?.cancel();
    personSubject.close();
  }
}
