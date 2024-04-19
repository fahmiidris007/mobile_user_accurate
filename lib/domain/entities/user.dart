import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;

  const User(
      {this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.city});

  @override
  List<Object?> get props => [id, name, email, address, phoneNumber, city];
}
