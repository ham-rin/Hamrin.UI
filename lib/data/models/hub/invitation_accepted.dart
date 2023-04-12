import 'package:hamrin_app/data/models/locations/point.dart';

class InvitationAccepted {
  late String name;
  late Point location;

  InvitationAccepted.formJson(Map<String, dynamic> json) {
    name = json['name'];
    location = Point.fromJson(json['location']);
  }
}
