import 'package:get_it/get_it.dart';
import 'package:mobile_user_accurate/data/datasources/city_remote_data_source.dart';
import 'package:mobile_user_accurate/data/datasources/user_remote_data_source.dart';
import 'package:mobile_user_accurate/data/repositories/city_repository_impl.dart';
import 'package:mobile_user_accurate/data/repositories/user_repository_impl.dart';
import 'package:mobile_user_accurate/domain/repositories/city_repository.dart';
import 'package:mobile_user_accurate/domain/repositories/user_repository.dart';
import 'package:mobile_user_accurate/domain/usecases/add_user.dart';
import 'package:mobile_user_accurate/domain/usecases/get_cities.dart';
import 'package:mobile_user_accurate/domain/usecases/get_users.dart';
import 'package:mobile_user_accurate/presentation/bloc/add_user/add_user_bloc.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_city/get_city_bloc.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => GetUserBloc(
      getUsers: locator(),
    ),
  );
  locator.registerFactory(
    () => AddUserBloc(
      addUser: locator(),
    ),
  );
  locator.registerFactory(
    () => GetCityBloc(
      getCities: locator(),
    ),
  );

  //usecase
  locator.registerLazySingleton(
    () => GetUsers(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => AddUser(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetCities(
      locator(),
    ),
  );

  //repository
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  //datasource
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<CityRemoteDataSource>(
    () => CityRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  //helper
  locator.registerLazySingleton(
    () => http.Client(),
  );
}
