import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? token;

  const User({
    required this.id,
    this.name,
    this.token,
  });

  @override
  List get props => [
        id,
        name,
        token,
      ];

  static const empty = User(id: '-');

  factory User.fromJson({
    required Map<String, dynamic> json,
    String? token,
  }) {
    return User(
      id: json['id'],
      name: json['name'],
      token: token,
    );
  }
}
