import 'package:chatly/models/message.dart';
import 'package:hive/hive.dart';

part 'contacts.g.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  final String number;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String senderUserNumber;

  @HiveField(3)
  final List<Message>? messages;

  Contact({
    required this.senderUserNumber,
    required this.number,
    this.name,
    this.messages,
  });

  static final empty = Contact(
    number: '',
    senderUserNumber: '',
  );

  factory Contact.fromJson({
    required Map<String, dynamic> json,
    String? token,
  }) {
    return Contact(
      number: json['number'],
      name: json['name'],
      senderUserNumber: json['senderUserNumber'],
      messages: json['messages'],
    );
  }
}
