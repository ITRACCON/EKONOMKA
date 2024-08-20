class PromocodeModel {
  int id;
  String promocode;
  int selProcent;

  PromocodeModel(
      {required this.id, required this.promocode, required this.selProcent});

  factory PromocodeModel.fromJson(Map<dynamic, dynamic> json) {
    return PromocodeModel(
        id: int.parse(json['id']),
        promocode: json['promocode'].toString(),
        selProcent: int.parse(json['skidka']));
  }
}
