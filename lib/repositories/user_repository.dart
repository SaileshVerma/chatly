import 'package:chatly/models/user.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static const String userBoxName = "userBox";

  Future<void> addUser(User user) async {
    final box = await Hive.openBox<User>(userBoxName);
    await box.put(user.number, user);
    getAllUsers();
  }

  Future<User?> getUser(String number) async {
    final box = await Hive.openBox<User>(userBoxName);
    return box.get(number);
  }

  Future<List<User>> getAllUsers() async {
    final box = await Hive.openBox<User>(userBoxName);
    return box.values.toList();
  }
}
