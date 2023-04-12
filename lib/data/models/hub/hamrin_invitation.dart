import 'package:hamrin_app/data/models/locations/point.dart';

class HamrinInvitation {
  late String id;
  late String name;
  late int distance;
  late Point location;

  HamrinInvitation.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    location = Point.fromJson(json['location']);
  }
}
