import 'package:dartz/dartz.dart';
import 'package:mobile_user_accurate/common/failure.dart';
import 'package:mobile_user_accurate/domain/entities/city.dart';
import 'package:mobile_user_accurate/domain/repositories/city_repository.dart';

class GetCities {
  final CityRepository repository;

  GetCities(this.repository);

  Future<Either<Failure, List<City>>> execute() async {
    return await repository.getCities();
  }
}
