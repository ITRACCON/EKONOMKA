class InfoApp {
  int percentRefs;
  String details;
  String onebanner;
  String twobanner;

  InfoApp(
      {required this.percentRefs,
      required this.details,
      required this.onebanner,
      required this.twobanner});

  factory InfoApp.fromJson(Map<dynamic, dynamic> json) {
    return InfoApp(
        percentRefs: int.parse(json['percentrefs'].toString()),
        details: json['details'],
        onebanner: json['onebanner'],
        twobanner: json['twobanner']);
  }
}
