import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:clean_architecture/features/data/datasources/person_local_data_source.dart';
import 'package:clean_architecture/features/data/datasources/person_remote_data_source.dart';
import 'package:clean_architecture/features/domain/repositories/person_repository.dart';
import 'package:clean_architecture/features/domain/usecases/get_all_persons.dart';
import 'package:clean_architecture/features/domain/usecases/search_person.dart';
import 'package:clean_architecture/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/search/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/repositories/person_repository_impl.dart';

final ls = GetIt.instance;

Future<void> init() async {
  /// BLoC / Cubit

  ls.registerFactory(() => PersonListCubit(getAllPersons: ls()));
  ls.registerFactory(() => PersonSearchBloc(searchPersons: ls()));

  /// UseCase
  ls.registerLazySingleton(() => GetAllPersons(ls()));
  ls.registerLazySingleton(() => SearchPerson(ls()));

  /// Repository
  ls.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: ls(),
      localDataSource: ls(),
      networkInfo: ls(),
    ),
  );

  ls.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(client: http.Client()),
  );

  ls.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(sharedPreferences: ls()),
  );

  /// Core

  ls.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(ls()));

  /// External
  final sharedPeferences = await SharedPreferences.getInstance();
  ls.registerLazySingleton(() => sharedPeferences);
  ls.registerLazySingleton(() => http.Client());
  ls.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
