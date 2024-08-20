import 'package:flutter/material.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shophimikat/data/local/hive_hellper.dart';
import 'package:shophimikat/data/local/locator.dart';
import 'package:shophimikat/app.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

void main() async {
  final WebAppInitData webAppInitData = tg.initDataUnsafe;

  if (webAppInitData.hash == null) {
    setupLocator();
    await Hive.initFlutter();
    HiveHelper.registerAdapters();
    await HiveHelper.openBoxes();
  } else {}

  runApp(const App());
}
