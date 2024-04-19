import 'package:dartz/dartz.dart';
import 'package:mobile_user_accurate/common/failure.dart';
import 'package:mobile_user_accurate/domain/entities/city.dart';

abstract class CityRepository {
  Future<Either<Failure, List<City>>> getCities();
}
