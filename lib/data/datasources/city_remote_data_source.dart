import 'dart:convert';

import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/common/exception.dart';
import 'package:mobile_user_accurate/data/models/city_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_user_accurate/data/models/city_response.dart';

abstract class CityRemoteDataSource {
  Future<List<CityModel>> getCities();
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  final http.Client client;

  CityRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CityModel>> getCities() async {
    final response = await client.get(Uri.parse('${BASE_URL}city'));

    if (response.statusCode == 200) {
      return CityResponse.fromJson(json.decode(response.body)).cityList;
    } else {
      throw ServerException();
    }
  }
}
