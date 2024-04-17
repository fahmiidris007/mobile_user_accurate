import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mobile_user_accurate/common/exception.dart';
import 'package:mobile_user_accurate/common/failure.dart';
import 'package:mobile_user_accurate/data/datasources/user_remote_data_source.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> addUser(User user) async {
    try {
      final result = await remoteDataSource.postUsers(user);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final result = await remoteDataSource.getUsers();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
