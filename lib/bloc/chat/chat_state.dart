import 'package:chatly/models/message.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final List<Message> messages;

  const ChatState({
    this.messages = const [],
  });

  @override
  List<Object> get props => [messages];
}
