import 'package:dartz/dartz.dart';
import 'package:encryption_drift/domain/entity/failure.dart';
import 'package:encryption_drift/domain/entity/person.dart';
import 'package:encryption_drift/domain/repository/person_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchPersonUseCase {
  final PersonRepository repository;

  WatchPersonUseCase({required this.repository});

  Future<Either<Failure, Stream<List<Person>>>> call() async {
    try {
      return Right(repository.watchPerson());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
