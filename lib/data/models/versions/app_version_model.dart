class AppVersion {
  late String latestAppVersion;
  late String minimumMandatoryAppVersion;
  late String link;

  AppVersion(
      {required this.latestAppVersion,
      required this.minimumMandatoryAppVersion,
      required this.link});

  AppVersion.fromJson(Map<String, dynamic> json) {
    latestAppVersion = json['latestAppVersion'];
    minimumMandatoryAppVersion = json['minimumMandatoryAppVersion'];
    link = json['link'];
  }
}
