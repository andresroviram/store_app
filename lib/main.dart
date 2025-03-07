import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:store_app/config/injectable/injectable_dependency.dart';
import 'package:store_app/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  runApp(const Providers());
}
