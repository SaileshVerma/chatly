import 'package:chatly/models/contacts.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/utils/constants/hive_boxes.dart';
import 'package:hive/hive.dart';

class ContactsRepositoryHiveService {
  Future<void> addContact(
      {required Contact contact,
      required String currentLoggedInUserNumber}) async {
    final box = await Hive.openBox<Contact>(CONTACTSBOX);
    await box.put(contact.number + currentLoggedInUserNumber, contact);
  }

  Future<Contact?> getContact(String number) async {
    final box = await Hive.openBox<Contact>(CONTACTSBOX);
    return box.get(number);
  }

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
      final key = number + currentLoggedInUserNumber;
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
}
