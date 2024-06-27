import 'package:chatly/models/message.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final String number;
  final String name;
  final String senderUserNumber;
  final List<Message> messages;
  final FormStatus status;

  const ChatState({
    this.number = '',
    this.name = '',
    this.senderUserNumber = '',
    this.messages = const [],
    this.status = FormStatus.initial,
  });

  ChatState copyWith({
    String? number,
    String? name,
    String? senderUserNumber,
    List<Message>? messages,
    FormStatus? status,
  }) {
    return ChatState(
      number: number ?? this.number,
      name: name ?? this.name,
      status: status ?? this.status,
      senderUserNumber: senderUserNumber ?? this.senderUserNumber,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object> get props => [
        number,
        name,
        senderUserNumber,
        messages,
        status,
      ];
}
