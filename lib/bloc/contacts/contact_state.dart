import 'package:chatly/models/contacts.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';

class ContactState extends Equatable {
  final String currentUserNumber;
  final List<Contact> contacts;
  final LoadingStatus loadingState;

  const ContactState({
    this.contacts = const [],
    this.currentUserNumber = '',
    this.loadingState = LoadingStatus.initial,
  });

  ContactState copyWith({
    String? currentUserNumber,
    List<Contact>? contacts,
    LoadingStatus? loadingState,
  }) {
    return ContactState(
      currentUserNumber: currentUserNumber ?? this.currentUserNumber,
      contacts: contacts ?? this.contacts,
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object> get props => [
        currentUserNumber,
        contacts,
        loadingState,
      ];
}
