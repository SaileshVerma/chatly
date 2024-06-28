import 'package:chatly/screens/chat_screen/add_contact_widgets/add_contact_submit_button.dart';
import 'package:chatly/screens/chat_screen/add_contact_widgets/add_name_field.dart';
import 'package:chatly/screens/chat_screen/add_contact_widgets/add_number_field.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddContactForm extends StatelessWidget {
  const AddContactForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text('Enter Details'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddNameField(),
            AddNumberField(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          AddDetailsSubmitButton(formKey: formKey),
        ],
      ),
    );
  }
}
