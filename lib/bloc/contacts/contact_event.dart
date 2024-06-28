import 'package:chatly/models/contacts.dart';
import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUserContactList extends ContactEvent {
  const GetCurrentUserContactList();
}

class AddContactToList extends ContactEvent {
  final Contact contact;
  const AddContactToList(this.contact);

  @override
  List<Object> get props => [contact];
}

class ClearContactsStates extends ContactEvent {
  const ClearContactsStates();
}
