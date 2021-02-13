import 'package:flutter/material.dart';

import 'package:weather/model/weather.dart';

import 'city_Screen.dart';

class HomeScreen extends StatefulWidget {
  final Weather weather;

  HomeScreen({this.weather});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String description = "";
  String conditionImage = "";
  String temp = "";
  String wind = "";
  String humid = "";
  String locationName = "";

  @override
  void initState() {
    updateUi(widget.weather);
    super.initState();
  }

  void updateUi(Weather weather) {
    setState(() {
      description = weather.description.toString();
      locationName = weather.locationName;
      temp = weather.temp;
      wind = weather.wind;
      humid = weather.humid;
      conditionImage = weather.conditionImage;
    });
  }

  String getIconFromCondition(String condition){

    switch(condition){
      case "01d":
      return "png/016-thermometer.png";
      break;

      default:
        return "png/016-thermometer.png";
        break;

    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        var weatherData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));

                        if(weatherData!=null){
                          updateUi(weatherData);
                        }


                      })
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                  child: Image(
                image: AssetImage(
                    getIconFromCondition(conditionImage)
                ),
                width: MediaQuery.of(context).size.width / 2,
              )),
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    Text(
                      '${locationName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        Text(
                          '${temp}°C',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 10,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Wind',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    '${wind} m/s',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 10,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Humidity',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    '${humid} %',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
