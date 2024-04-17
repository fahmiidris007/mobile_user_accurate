import 'package:get_it/get_it.dart';
import 'package:mobile_user_accurate/data/datasources/user_remote_data_source.dart';
import 'package:mobile_user_accurate/data/repositories/user_repository_impl.dart';
import 'package:mobile_user_accurate/domain/repositories/user_repository.dart';
import 'package:mobile_user_accurate/domain/usecases/get_users.dart';
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

  //usecase
  locator.registerLazySingleton(() => GetUsers(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));

  //datasource
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: locator()));

  //helper
  locator.registerLazySingleton(() => http.Client());
}
