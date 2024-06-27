import 'package:chatly/models/message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ContactNumberChanged extends ChatEvent {
  final String number;

  const ContactNumberChanged(this.number);

  @override
  List<Object> get props => [number];
}

class ContactNameChanged extends ChatEvent {
  final String name;

  const ContactNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class AddContactMessage extends ChatEvent {
  final Message message;
  const AddContactMessage(this.message);

  @override
  List<Object> get props => [message];
}

class AddContactDetails extends ChatEvent {
  const AddContactDetails();
}

class ClearChatStates extends ChatEvent {
  const ClearChatStates();
}
