import 'package:geolocator/geolocator.dart';

class UserLocation{

      Future<Position> getUserPosition() async {
      return  await Geolocator.getCurrentPosition();

      }
}