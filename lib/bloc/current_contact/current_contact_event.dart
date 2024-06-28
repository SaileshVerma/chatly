import 'package:chatly/models/contacts.dart';
import 'package:chatly/models/message.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentContactEvent extends Equatable {
  const CurrentContactEvent();

  @override
  List<Object> get props => [];
}

class UpdateCurrentContact extends CurrentContactEvent {
  final Contact contact;
  const UpdateCurrentContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class AddCurrentContactMessage extends CurrentContactEvent {
  final String currentLoggedInUserNumber;
  final Message message;

  const AddCurrentContactMessage({
    required this.message,
    required this.currentLoggedInUserNumber,
  });

  @override
  List<Object> get props => [message, currentLoggedInUserNumber];
}

class ClearCurrentContactsStates extends CurrentContactEvent {
  const ClearCurrentContactsStates();
}
