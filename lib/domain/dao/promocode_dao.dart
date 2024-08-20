
import 'package:shophimikat/domain/models/promocode_model.dart';

List<PromocodeModel> getListPromocodes(List data) {
  return List.generate(data.length, (id) => PromocodeModel.fromJson(data[id]));
}
