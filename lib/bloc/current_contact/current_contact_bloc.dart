import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/current_contact/current_contact_event.dart';
import 'package:chatly/bloc/current_contact/current_contact_state.dart';

class CurrentContactBloc
    extends Bloc<CurrentContactEvent, CurrentContactState> {
  CurrentContactBloc()
      : super(
          const CurrentContactState(),
        ) {
    on<UpdateCurrentContact>(_onUpdateCurrentContact);
    on<ClearCurrentContactsStates>(_onClearCurrentContactsStates);
  }

  _onUpdateCurrentContact(
      UpdateCurrentContact event, Emitter<CurrentContactState> emit) {
    emit(state.copyWith(currentContact: event.contact));
  }

  _onClearCurrentContactsStates(
      ClearCurrentContactsStates event, Emitter<CurrentContactState> emit) {
    emit(const CurrentContactState());
  }
}
