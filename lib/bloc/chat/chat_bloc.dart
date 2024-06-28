import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/chat/chat_event.dart';
import 'package:chatly/bloc/chat/chat_state.dart';
import 'package:chatly/models/contacts.dart';
import 'package:chatly/repositories/contacts_repository.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/enums.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ContactsRepositoryHiveService contactsRepositoryHiveService;
  final HiveService userHiveService;

  ChatBloc()
      : contactsRepositoryHiveService = ContactsRepositoryHiveService(),
        userHiveService = HiveService(),
        super(
          const ChatState(),
        ) {
    on<AddContactDetails>(_onAddContactDetails);
    on<ClearChatStates>(_onClearChatStates);
    on<ContactNumberChanged>(_onContactNumberChanged);
    on<ContactNameChanged>(_onContactNameChanged);
    on<AddContactMessage>(_onAddContactMessage);
  }

  _onContactNumberChanged(ContactNumberChanged event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(number: event.number),
    );
  }

  _onContactNameChanged(ContactNameChanged event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(name: event.name),
    );
  }

  _onAddContactMessage(AddContactMessage event, Emitter<ChatState> emit) {
    final message = event.message;

    final previousMessages = state.messages;
    previousMessages.add(message);

    emit(
      state.copyWith(
        messages: previousMessages,
      ),
    );
  }

  _onAddContactDetails(AddContactDetails event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.inProgress));

      final currentLoggedInUser = await userHiveService.getLoggedInUser();

      // if (state.name == null || user.password != state.password) {
      //   emit(state.copyWith(
      //     formStatus: FormStatus.failure,
      //     errorMessage: 'Invalid username or password',
      //   ));
      //   return;
      // }

      final Contact newContact = Contact(
        number: state.number,
        name: state.name,
        senderUserNumber: currentLoggedInUser?.number ?? '',
        messages: state.messages,
      );

      print("BEFORE--> ${newContact.senderUserNumber}");

      await contactsRepositoryHiveService.addContact(
        contact: newContact,
        currentLoggedInUserNumber: currentLoggedInUser?.number ?? '',
      );

      emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      );
    } catch (error) {
      print("ERROR HI ERROR *(*(*()))#$error");
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }
  }

  _onClearChatStates(ClearChatStates event, Emitter<ChatState> emit) {
    emit(
      const ChatState(),
    );
  }
}
