import 'dart:convert';

import 'package:weather/model/weather.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  String _baseUrl = "http://api.openweathermap.org/data/2.5/weather";
  String _apiKey = "eb41ad944236215dc78c4ad4c914177f";

  String getLocationUrl(double lat, double lon) {
    return "$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric";
  }

  String getCityUrl(String cityName) {
    return "$_baseUrl?q=$cityName&appid=$_apiKey&units=metric";
  }

  Future<Weather> getWeatherResultfromGps(double lat, double lon) async {
    Weather _weather = Weather();

    try {
      var response = await http.get(getLocationUrl(lat, lon));


      var result = json.decode(response.body);

      _weather.description = result["weather"][0]['description'];
      _weather.locationName = result["name"];
      _weather.temp = result["main"]["temp"].toString();
      _weather.humid = result["main"]["humidity"].toString();
      _weather.wind = result["wind"]["speed"].toString();
      _weather.conditionImage = result["weather"][0]['icon'];


      return _weather;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Weather> getWeatherFromCityName(String cityName) async {
    Weather _weather = Weather();

    try {
      var response = await http.get(getCityUrl(cityName));

      var result = json.decode(response.body);

      _weather.description = result["weather"][0]['description'];
      _weather.locationName = result["name"];
      _weather.temp = result["main"]["temp"].toString();
      _weather.humid = result["main"]["humidity"].toString();
      _weather.wind = result["wind"]["speed"].toString();
      _weather.conditionImage = result["weather"][0]['icon'];

      return _weather;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
