import 'package:equatable/equatable.dart';
import 'package:mobile_user_accurate/data/models/city_model.dart';

class CityResponse extends Equatable {
  final List<CityModel> cityList;

  const CityResponse({required this.cityList});

  factory CityResponse.fromJson(List<dynamic> json) =>
      CityResponse(cityList: json.map((x) => CityModel.fromJson(x)).toList());

  @override
  List<Object> get props => [cityList];
}
