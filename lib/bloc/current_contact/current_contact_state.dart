import 'package:chatly/models/contacts.dart';
import 'package:equatable/equatable.dart';

class CurrentContactState extends Equatable {
  final Contact? currentContact;

  const CurrentContactState({
    this.currentContact,
  });

  CurrentContactState copyWith({
    Contact? currentContact,
  }) {
    return CurrentContactState(
      currentContact: currentContact ?? this.currentContact,
    );
  }

  @override
  List get props => [
        currentContact,
      ];
}
