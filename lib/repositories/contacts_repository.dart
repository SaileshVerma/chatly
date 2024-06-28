import 'package:chatly/models/contacts.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/utils/constants/hive_boxes.dart';
import 'package:hive/hive.dart';

class ContactsRepositoryHiveService {
  Future<void> addContact(
      {required Contact contact,
      required String currentLoggedInUserNumber}) async {
    final box = await Hive.openBox<Contact>(CONTACTSBOX);
    await box.put(contact.number, contact);
  }

  // Future<Contact?> getContact(String number) async {
  //   final box = await Hive.openBox<Contact>(CONTACTSBOX);

  //   return box.get(number);
  // }

  Future<List<Contact>> getAllGlobalContacts() async {
    final box = await Hive.openBox<Contact>(CONTACTSBOX);

    return box.values.toList();
  }

  Future<List<Contact>> getCurrentLoggedInUserContacts(
      {required String currentUserNumber}) async {
    final box = await Hive.openBox<Contact>(CONTACTSBOX);

    final globalList = box.values.toList();

    final newList = globalList
        .where((element) => element.senderUserNumber == currentUserNumber);

    return newList.toList();
  }

  Future<void> addMessageToContact({
    required String number,
    required String currentLoggedInUserNumber,
    required Message newMessage,
  }) async {
    try {
      final box = await Hive.openBox<Contact>(CONTACTSBOX);
      final key = number;
      final contact = box.get(key);

      if (contact != null) {
        final updatedMessages = List<Message>.from(contact.messages ?? []);
        updatedMessages.add(newMessage);

        final updatedContact = Contact(
          number: contact.number,
          name: contact.name,
          senderUserNumber: contact.senderUserNumber,
          messages: updatedMessages,
        );

        await box.put(key, updatedContact);
      }
    } catch (error) {}
  }

  // Future<void> addMessage(Message message) async {
  //   final box = await Hive.openBox<Message>(MESSAGESBOX);
  //   await box.put(message.id, message);
  // }

  // Future<Message?> getMessage(String id) async {
  //   final box = await Hive.openBox<Message>(MESSAGESBOX);
  //   return box.get(id);
  // }

  Future<List<Message>> getCurrentAndSenderMessages({
    required String number,
    required String currentLoggedInUserNumber,
  }) async {
    final box = await Hive.openBox<Contact>(CONTACTSBOX);
    final receiverKey = number;
    final senderKey = currentLoggedInUserNumber;

    final receiverContact = box.get(receiverKey);
    final senderContact = box.get(senderKey);

    final List<Message> bothMessagesList = [];

    if (receiverContact != null && senderContact != null) {
      var receiverMessages = List<Message>.from(receiverContact.messages ?? []);

      var senderMessages = List<Message>.from(senderContact.messages ?? []);

      receiverMessages = receiverMessages
          .where((element) => element.createdByNumber == senderKey)
          .toList();

      senderMessages = senderMessages
        ..where((element) => element.createdByNumber == receiverKey).toList();

      final newMergedList = [...receiverMessages, ...senderMessages];
      newMergedList.sort((a, b) => (a.timestamp ?? (DateTime.now()))
          .compareTo((b.timestamp ?? (DateTime.now()))));
      bothMessagesList.addAll(newMergedList);
    }

    return bothMessagesList;
  }
}
