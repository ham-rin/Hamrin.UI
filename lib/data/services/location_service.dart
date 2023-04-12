import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hamrin_app/core/utils/dio_tools.dart';
import 'package:hamrin_app/data/models/locations/point.dart';

class LocationService {
  static final Dio _dio = DioTools.getDioInstance("locations/");

  Future<Point> getLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var point =
        Point(latitude: position.latitude, longitude: position.longitude);
    return point;
  }

  Future updateLocation() async {
    var point = await getLocation();
    await _dio.post("update/", data: point.toJson());
  }
}
