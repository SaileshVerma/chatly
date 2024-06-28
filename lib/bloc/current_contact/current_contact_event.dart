import 'package:chatly/models/contacts.dart';
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

class ClearCurrentContactsStates extends CurrentContactEvent {
  const ClearCurrentContactsStates();
}
