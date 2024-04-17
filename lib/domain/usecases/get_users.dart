import 'package:dartz/dartz.dart';
import 'package:mobile_user_accurate/common/failure.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<User>>> execute() async {
    return await repository.getUsers();
  }
}
