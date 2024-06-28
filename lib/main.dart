import 'package:chatly/models/contacts.dart';
import 'package:chatly/models/message.dart';
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
    Hive.registerAdapter(ContactAdapter());
    Hive.registerAdapter(MessageAdapter());

    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}
