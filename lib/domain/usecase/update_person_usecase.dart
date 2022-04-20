import 'package:dartz/dartz.dart';
import 'package:encryption_drift/domain/entity/failure.dart';
import 'package:encryption_drift/domain/repository/person_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePersonUseCase {
  final PersonRepository repository;

  UpdatePersonUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    try {
      return Right(repository.updatePerson());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
