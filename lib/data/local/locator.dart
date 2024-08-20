import 'package:get_it/get_it.dart';

import 'hive_operations.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<HiveOperationsService>(
    () => HiveOperationsService(),
  );

}