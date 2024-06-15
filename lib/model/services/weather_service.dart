import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:openweather_mvvm/model/api/app_exception.dart';
import 'package:openweather_mvvm/model/services/base_service.dart';


class WeatherService extends BaseService {

  @override
  Future getResponse(String city) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse("$baseURL?q=$city$appIdPath"));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getResponseByLocation(double lat, double long) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse("$baseURL?lat=$lat&lon=$long$appIdPath")
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }


  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }



}