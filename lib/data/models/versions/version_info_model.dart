class VersionInfo {
  late String releaseDate;
  late ChangeLog changeLog;

  VersionInfo({required this.releaseDate, required this.changeLog});

  VersionInfo.fromJson(Map<String, dynamic> json) {
    releaseDate = json['releaseDate'];
    changeLog = ChangeLog.fromJson(json['changeLog']);
  }
}

class ChangeLog {
  late String description;
  late List<String> items;

  ChangeLog({required this.description, required this.items});

  ChangeLog.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    items = json['items'].cast<String>();
  }
}
