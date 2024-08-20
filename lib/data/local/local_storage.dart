import 'package:shophimikat/domain/models/user_model.dart';

class UserTgProvider {
  static UserModel? user = UserModel(
      userId: 0,
      phone: '',
      referalcode: '',
      coin: 0,
      typeAcc: 'tg',
      userTgId: '',
      userTgFl: '',
      userTgName: '',
      admin: 0);

  static updateUser(UserModel newUser) async {
    user = newUser;
  }

  static getUser() {
    return user;
  }
}
