import 'dart:convert';

import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/common/exception.dart';
import 'package:mobile_user_accurate/data/models/user_model.dart';
import 'package:mobile_user_accurate/data/models/user_response.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> postUsers(Map<String, dynamic> user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(Uri.parse('${BASE_URL}user'));

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body)).userList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> postUsers(Map<String, dynamic> user) async {
    final response = await client.post(
      Uri.parse('${BASE_URL}user'),
      body: user,
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
