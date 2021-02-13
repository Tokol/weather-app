import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/homepage.dart';
import 'package:weather/services/locationservice.dart';
import 'package:weather/services/network_handler.dart';

import 'model/weather.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestWeather();
    super.initState();
  }

  void requestWeather() async {
    try {
      UserLocation _userLocation = UserLocation();
      NetworkHandler _netWorkHandler = NetworkHandler();
      Position _position = await _userLocation.getUserPosition();

      if (_position != null) {
        Weather _weather = await _netWorkHandler.getWeatherResultfromGps(
            _position.latitude, _position.longitude);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      weather: _weather,
                    )));
      }
    } catch (e) {
      print('somethinw went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Loading weather data..',
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.w600, letterSpacing: 1.2),
        ),
        SizedBox(
          height: 10,
        ),
        SpinKitPouringHourglass(
          color: Colors.red,
          size: 50.0,
        ),
      ],
    ));
  }
}
