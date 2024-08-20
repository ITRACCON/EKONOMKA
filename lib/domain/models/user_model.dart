class UserModel {
  int userId;
  String phone;
  String referalcode;
  int coin;
  String typeAcc;
  String userTgId;
  String userTgFl;
  String userTgName;
  int admin;

  UserModel(
      {required this.userId,
      required this.phone,
      required this.referalcode,
      required this.coin,
      required this.typeAcc,
      required this.userTgId,
      required this.userTgFl,
      required this.userTgName,
      required this.admin});

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      userId: int.parse(json['id']),
      phone: json['phone'].toString(),
      referalcode: json['referalcode'].toString(),
      coin: int.parse(json['coin']),
      typeAcc: json['usertgid'] == null ? 'web' : 'tg',
      userTgId: json['usertgid'].toString(),
      userTgFl: json['usertgfl'].toString(),
      userTgName: json['usertgname'].toString(),
      admin: int.parse(json['admin']),
    );
  }
}
