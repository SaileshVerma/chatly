import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/current_contact/current_contact_event.dart';
import 'package:chatly/bloc/current_contact/current_contact_state.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/repositories/contacts_repository.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/enums.dart';

class CurrentContactBloc
    extends Bloc<CurrentContactEvent, CurrentContactState> {
  final ContactsRepositoryHiveService contactsRepositoryHiveService;
  final HiveService userHiveService;
  CurrentContactBloc()
      : contactsRepositoryHiveService = ContactsRepositoryHiveService(),
        userHiveService = HiveService(),
        super(
          const CurrentContactState(),
        ) {
    on<UpdateCurrentContact>(_onUpdateCurrentContact);
    on<AddCurrentContactMessage>(_onAddCurrentContactMessage);
    on<ClearCurrentContactsStates>(_onClearCurrentContactsStates);
  }

  _onUpdateCurrentContact(
      UpdateCurrentContact event, Emitter<CurrentContactState> emit) async {
    final currentContact = event.contact;

    final currentLoggedInUser = await userHiveService.getLoggedInUser();

    final newMessageList =
        await contactsRepositoryHiveService.getCurrentAndSenderMessages(
            number: event.contact.number,
            currentLoggedInUserNumber: currentLoggedInUser?.number ?? "");

    emit(
      state.copyWith(
        currentContact: currentContact.copyWith(
          messages: newMessageList,
        ),
      ),
    );
  }

  _onAddCurrentContactMessage(
      AddCurrentContactMessage event, Emitter<CurrentContactState> emit) async {
    try {
      emit(state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ));

      final message = event.message;
      final previousMessages =
          List<Message>.from(state.currentContact?.messages ?? []);
      previousMessages.add(message);

      final prevContact = state.currentContact;

      await contactsRepositoryHiveService.addMessageToContact(
          currentLoggedInUserNumber: event.currentLoggedInUserNumber,
          newMessage: event.message,
          number: state.currentContact?.number ?? "");

      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.complete,
          currentContact: prevContact?.copyWith(
            messages: previousMessages,
          ),
        ),
      );
    } catch (error) {}
  }

  _onClearCurrentContactsStates(
      ClearCurrentContactsStates event, Emitter<CurrentContactState> emit) {
    emit(const CurrentContactState());
  }
}
