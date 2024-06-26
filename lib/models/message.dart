import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String? sender;
  final String? content;
  final DateTime? timestamp;

  const Message({
    required this.id,
    this.sender,
    this.content,
    this.timestamp,
  });

  Message copyWith({
    String? id,
    String? sender,
    String? content,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory Message.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Message(
      id: json["id"],
      content: json["content"],
      sender: json["sender"],
      timestamp: json["timestamp"],
    );
  }
  @override
  List get props => [id, content, sender, timestamp];
}
