import 'package:flutter/material.dart';
import 'package:chatly/app/my_app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tempBox');
  runApp(const MyApp());
}
