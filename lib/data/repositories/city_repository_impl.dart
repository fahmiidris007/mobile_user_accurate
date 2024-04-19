import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mobile_user_accurate/common/exception.dart';
import 'package:mobile_user_accurate/common/failure.dart';
import 'package:mobile_user_accurate/data/datasources/city_remote_data_source.dart';
import 'package:mobile_user_accurate/domain/entities/city.dart';
import 'package:mobile_user_accurate/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource remoteDataSource;

  CityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      final result = await remoteDataSource.getCities();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
