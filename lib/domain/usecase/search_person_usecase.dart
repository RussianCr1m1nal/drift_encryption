
import 'package:encryption_drift/domain/repository/person_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPersonUseCase {
  final PersonRepository repository;

  SearchPersonUseCase({required this.repository});
}