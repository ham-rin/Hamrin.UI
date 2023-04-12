import 'package:hamrin_app/data/models/locations/point.dart';

class UserLocation{
  late String id;
  late Point location;

  UserLocation.formJson(Map<String, dynamic> json) {
    id = json['id'];
    location = Point.fromJson(json['location']);
  }
}