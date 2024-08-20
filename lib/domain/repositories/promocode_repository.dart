import 'package:shophimikat/data/server/api.dart';

class PromocodeRepository {
  final Api _appApi = Api();

  Future<Map> checkPromocode(String promocode) async {
    Map res = await _appApi.checkPromocode(promocode);
    return res;
  }

  Future<Map> getPromocodes() async {
    Map res = await _appApi.getPromocodes();
    print(res);
    return res;
  }

  Future<bool> addPromocode(String promocode, int skidka) async {
    print('REP');
    bool res = await _appApi.addPromocode(promocode, skidka);
    return res;
  }
}
