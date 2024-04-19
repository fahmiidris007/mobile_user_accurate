import 'package:equatable/equatable.dart';
import 'package:mobile_user_accurate/data/models/user_model.dart';

class UserResponse extends Equatable {
  final List<UserModel> userList;

  const UserResponse({required this.userList});

  factory UserResponse.fromJson(List<dynamic> json) =>
      UserResponse(userList: json.map((x) => UserModel.fromJson(x)).toList());

  @override
  List<Object?> get props => [userList];
}
