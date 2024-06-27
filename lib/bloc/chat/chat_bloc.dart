import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/chat/chat_event.dart';
import 'package:chatly/bloc/chat/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(
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

  _onAddContactDetails(AddContactDetails event, Emitter<ChatState> emit) {}

  _onClearChatStates(ClearChatStates event, Emitter<ChatState> emit) {
    emit(
      const ChatState(),
    );
  }
}
