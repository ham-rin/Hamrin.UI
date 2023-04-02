import 'package:geolocator/geolocator.dart';
import 'package:hamrin_app/data/models/locations/point.dart';

class LocationService {
  Future<Point> getLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var point =
        Point(latitude: position.latitude, longitude: position.longitude);
    return point;
  }
}
