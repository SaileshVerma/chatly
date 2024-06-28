import 'package:chatly/models/contacts.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';

class CurrentContactState extends Equatable {
  final Contact? currentContact;
  final LoadingStatus? loadingStatus;

  const CurrentContactState({
    this.currentContact,
    this.loadingStatus = LoadingStatus.initial,
  });

  CurrentContactState copyWith({
    Contact? currentContact,
    LoadingStatus? loadingStatus,
  }) {
    return CurrentContactState(
      currentContact: currentContact ?? this.currentContact,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List get props => [currentContact, loadingStatus];
}
