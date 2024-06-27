import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String number;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? password;

  @HiveField(3)
  final String? token;

  User({
    required this.number,
    this.name,
    this.token,
    this.password,
  });

  static final empty = User(number: '-');

  factory User.fromJson({
    required Map<String, dynamic> json,
    String? token,
  }) {
    return User(
      number: json['number'],
      name: json['name'],
      password: json['password'],
      token: token,
    );
  }
}
