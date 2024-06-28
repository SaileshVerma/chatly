import 'package:chatly/models/user.dart';
import 'package:chatly/utils/constants/hive_boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveService {
  Future<void> addUser(User user) async {
    final box = await Hive.openBox<User>(USERBOX);
    await box.put(user.number, user);
  }

  Future<User?> getUser(String number) async {
    final box = await Hive.openBox<User>(USERBOX);
    return box.get(number);
  }

  Future<List<User>> getAllUsers() async {
    final box = await Hive.openBox<User>(USERBOX);
    return box.values.toList();
  }

  Future<void> saveLoggedInUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', user.number);
  }

  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final number = prefs.getString(
        'loggedInUser'); //TODO: NEED TO UPDATE THIS BASED ON SOME KEY
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
