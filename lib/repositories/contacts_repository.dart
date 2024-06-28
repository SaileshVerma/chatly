import 'package:chatly/models/contacts.dart';
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
    box.values.forEach((element) {
      print('333333333${element.name}');
    });

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
}
