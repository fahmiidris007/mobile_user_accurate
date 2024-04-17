import 'package:equatable/equatable.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;

  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.city});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
        "city": city,
      };

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      address: address,
      phoneNumber: phoneNumber,
      city: city,
    );
  }

  @override
  List<Object> get props => [id, name, email, address, phoneNumber, city];
}
