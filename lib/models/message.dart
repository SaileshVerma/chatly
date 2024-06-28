import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 2)
class Message extends Equatable {
  @HiveField(0)
  final String? content;

  @HiveField(1)
  final DateTime? timestamp;

  @HiveField(2)
  final String? createdByNumber;

  const Message({
    this.content,
    this.timestamp,
    this.createdByNumber,
  });

  Message copyWith({
    String? content,
    String? createdByNumber,
    DateTime? timestamp,
  }) {
    return Message(
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      createdByNumber: createdByNumber ?? this.createdByNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'timestamp': timestamp?.toIso8601String(),
    };
  }

  factory Message.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Message(
      content: json["content"],
      createdByNumber: json["createdByNumber"],
      timestamp: DateTime.tryParse(json["timestamp"]),
    );
  }
  @override
  List get props => [
        content,
        timestamp,
        createdByNumber,
      ];
}
