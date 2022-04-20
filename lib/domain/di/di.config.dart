// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/database/database.dart' as _i3;
import '../../data/datasource/db_datasource.dart' as _i4;
import '../../data/datasource/db_datasource_impl.dart' as _i5;
import '../../presentation/bloc/person_list_bloc.dart' as _i11;
import '../repository/person_repository.dart' as _i6;
import '../repository/person_repository_impl.dart' as _i7;
import '../usecase/search_person_usecase.dart' as _i8;
import '../usecase/update_person_usecase.dart' as _i9;
import '../usecase/watch_person_usecase.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AppDataBase>(_i3.AppDataBase());
  gh.singleton<_i4.DBDatasource>(
      _i5.DBDatasourceImpl(dataBase: get<_i3.AppDataBase>()));
  gh.singleton<_i6.PersonRepository>(
      _i7.PersonRepositoryImpl(datasource: get<_i4.DBDatasource>()));
  gh.factory<_i8.SearchPersonUseCase>(
      () => _i8.SearchPersonUseCase(repository: get<_i6.PersonRepository>()));
  gh.factory<_i9.UpdatePersonUseCase>(
      () => _i9.UpdatePersonUseCase(repository: get<_i6.PersonRepository>()));
  gh.factory<_i10.WatchPersonUseCase>(
      () => _i10.WatchPersonUseCase(repository: get<_i6.PersonRepository>()));
  gh.factory<_i11.PersonListBloc>(() => _i11.PersonListBloc(
      watchPersonUseCase: get<_i10.WatchPersonUseCase>(),
      searchPersonUseCase: get<_i8.SearchPersonUseCase>(),
      updatePersonUseCase: get<_i9.UpdatePersonUseCase>()));
  return get;
}
