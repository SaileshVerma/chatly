import 'package:chatly/models/user.dart';
import 'package:flutter/material.dart';
import 'package:chatly/app/my_app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  try {
    // Initialize Hive
    await Hive.initFlutter();

    // Register the adapter
    Hive.registerAdapter(UserAdapter());

    runApp(MyApp());
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}
