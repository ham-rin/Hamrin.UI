class FoundHamrin {
  late String id;
  late String name;
  late int distance;

  FoundHamrin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
  }
}
