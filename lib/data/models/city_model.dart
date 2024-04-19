import 'package:equatable/equatable.dart';
import 'package:mobile_user_accurate/domain/entities/city.dart';

class CityModel extends Equatable {
  final String id;
  final String name;

  const CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  City toEntity() {
    return City(
      id: id,
      name: name,
    );
  }

  @override
  List<Object> get props => [id, name];
}
