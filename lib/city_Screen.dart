import 'package:flutter/material.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/services/network_handler.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String _cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,

      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[200],
        title: Text('City'),),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),

        child: TextField(
            style: TextStyle(
              color: Colors.blue,
            ),
          onChanged: (value){
            _cityName = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            fillColor: Colors.white,

            suffixIcon: IconButton(icon: Icon(Icons.done),color: Colors.orangeAccent, onPressed: () async {

              if(_cityName!=null && _cityName.isNotEmpty){

                      Weather weather =   await NetworkHandler().getWeatherFromCityName(_cityName);

                      Navigator.pop(context,weather);

              }

              else{
                print('city field is empty');
              }


            },),
            icon: Icon(Icons.add_location, color: Colors.white, size: 44.0,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none

            )

          ),
        ),
      ),
    );
  }
}
