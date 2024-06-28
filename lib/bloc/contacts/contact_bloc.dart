import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/contacts/contact_event.dart';
import 'package:chatly/bloc/contacts/contact_state.dart';
import 'package:chatly/models/contacts.dart';
import 'package:chatly/repositories/contacts_repository.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/enums.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactsRepositoryHiveService contactsRepositoryHiveService;
  final HiveService userHiveService;

  ContactBloc()
      : contactsRepositoryHiveService = ContactsRepositoryHiveService(),
        userHiveService = HiveService(),
        super(
          const ContactState(),
        ) {
    on<GetCurrentUserContactList>(_onGetCurrentUserContactList);
    on<AddContactToList>(_onAddContactToList);
    on<ClearContactsStates>(_onClearContactsStates);
  }

  _onGetCurrentUserContactList(
      GetCurrentUserContactList event, Emitter<ContactState> emit) async {
    emit(
      state.copyWith(
        loadingState: LoadingStatus.loading,
      ),
    );

    final currentLoggedInUser = await userHiveService.getLoggedInUser();

    final List<Contact> myContacts =
        await contactsRepositoryHiveService.getCurrentLoggedInUserContacts(
      currentUserNumber: currentLoggedInUser?.number ?? "",
    );

    emit(
      state.copyWith(
        loadingState: LoadingStatus.complete,
        contacts: myContacts,
      ),
    );
  }

  _onAddContactToList(AddContactToList event, Emitter<ContactState> emit) {
    emit(
      state.copyWith(
        loadingState: LoadingStatus.loading,
      ),
    );

    final prevList = state.contacts;

    prevList.add(event.contact);

    emit(
      state.copyWith(
        loadingState: LoadingStatus.complete,
        contacts: prevList,
      ),
    );
  }

  _onClearContactsStates(
      ClearContactsStates event, Emitter<ContactState> emit) {
    emit(
      const ContactState(),
    );
  }
}
