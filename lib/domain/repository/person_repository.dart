
import 'package:encryption_drift/domain/entity/person.dart';

abstract class PersonRepository {
  Stream<List<Person>> watchPerson();
  Future<void> updatePerson();
}