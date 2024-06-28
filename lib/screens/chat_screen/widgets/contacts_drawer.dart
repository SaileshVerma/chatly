import 'package:chatly/screens/chat_screen/widgets/logout_button.dart';
import 'package:chatly/screens/chat_screen/widgets/user_contacts_list.dart';
import 'package:flutter/material.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              maxRadius: 50,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
          Text("Welcome LoggedInUser"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: UserContactList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LogoutButton(),
          ),
        ],
      ),
    );
  }
}
