import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/common/exception.dart';
import 'package:mobile_user_accurate/data/models/user_model.dart';
import 'package:mobile_user_accurate/data/models/user_response.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_user_accurate/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<List<UserModel>> postUsers(User user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(Uri.parse(BASE_URL));

    if (response.statusCode == 200) {
      debugPrint('remote data success. response: ${response.body}');
      return UserResponse.fromJson(json.decode(response.body)).userList;
    } else {
      debugPrint('remote data failed. response: ${response.body}');
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> postUsers(User user) async {
    final response = await client.post(
      Uri.parse(BASE_URL),
      body: user,
    );

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body)).userList;
    } else {
      throw ServerException();
    }
  }
}
