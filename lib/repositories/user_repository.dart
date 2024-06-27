import 'package:chatly/models/user.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> saveLoggedInUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', user.number);
  }

  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final number = prefs.getString('loggedInUser');
    if (number != null) {
      return getUser(number);
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
  }
}
