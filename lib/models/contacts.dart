import 'package:chatly/models/message.dart';

class Contact {
  final String number;
  final String? name;
  final String? senderUserNumber;
  final List<Message>? messages;

  Contact({
    required this.number,
    this.name,
    this.senderUserNumber,
    this.messages,
  });

  static final empty = Contact(
    number: '',
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
