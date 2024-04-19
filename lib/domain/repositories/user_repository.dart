import 'package:dartz/dartz.dart';
import 'package:mobile_user_accurate/common/failure.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, User>> addUser(User user);
}
