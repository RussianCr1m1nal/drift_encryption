import 'dart:async';

import 'package:encryption_drift/benchmarks/delete_benchmark.dart';
import 'package:encryption_drift/benchmarks/insert_benchmark.dart';
import 'package:encryption_drift/benchmarks/select_benchmark.dart';
import 'package:encryption_drift/benchmarks/update_benchmark.dart';
import 'package:encryption_drift/domain/entity/person.dart';
import 'package:encryption_drift/domain/usecase/search_person_usecase.dart';
import 'package:encryption_drift/domain/usecase/update_person_usecase.dart';
import 'package:encryption_drift/domain/usecase/watch_person_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class PersonListBloc {
  final WatchPersonUseCase watchPersonUseCase;
  final SearchPersonUseCase searchPersonUseCase;
  final UpdatePersonUseCase updatePersonUseCase;

  final TextEditingController searchFieldController = TextEditingController();

  BehaviorSubject<List<Person>> personSubject = BehaviorSubject<List<Person>>.seeded([]);
  Stream<List<Person>> get personStream => personSubject.stream;
  StreamSubscription? personSubscription;

  PersonListBloc({
    required this.watchPersonUseCase,
    required this.searchPersonUseCase,
    required this.updatePersonUseCase,
  }) {
    _watchPerson();

    searchFieldController.addListener(() {
      print(searchFieldController.text);
    });
  }

  _watchPerson() async {
    (await watchPersonUseCase()).fold((failure) {
      print(failure.message);
    }, (stream) {
      personSubscription?.cancel();
      personSubscription = stream.listen((personList) {
        personSubject.add(personList);
      });
    });
  }

  void update() async {
    await InsertBenchmark.run();
    await SelectBenchmark.run();
    await UpdateBenchmark.run();
    await DeleteBenchmark.run();
  }

  void dispose() {
    searchFieldController.dispose();
    personSubscription?.cancel();
    personSubject.close();
  }
}
