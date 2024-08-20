import 'package:hive/hive.dart';

part 'user_hive.g.dart';

@HiveType(typeId: 1)
class UserHive {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String referalcode;
  @HiveField(3)
  final int coin;
  @HiveField(4)
  final String typeAcc;
  @HiveField(5)
  final String userTgId;
  @HiveField(6)
  final String userTgFl;
  @HiveField(7)
  final String userTgName;
  @HiveField(9)
  final int admin;

  UserHive(this.userId, this.phone, this.referalcode, this.coin, this.typeAcc,
      this.userTgId, this.userTgFl, this.userTgName, this.admin);
}
