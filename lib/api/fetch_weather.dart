import 'dart:convert';

import 'package:weather_app/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/model/weather_data_daily.dart';

import '../model/weather_data_hourly.dart';

class FetchWeatherApi {
  WeatherData? weatherdata;

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherdata = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherdata!;
  }
}

String apiUrl(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=111e76f07e2c48a7d42b3fedbf8f9f4f&units=metric";
  return url;
}
