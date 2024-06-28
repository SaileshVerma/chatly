import 'package:chatly/models/user.dart';
import 'package:chatly/screens/chat_screen/widgets/logout_button.dart';
import 'package:chatly/screens/chat_screen/widgets/user_contacts_list.dart';
import 'package:chatly/widgets/custom_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatDrawer extends StatelessWidget {
  final User? loggedInUser;

  const ChatDrawer({
    required this.loggedInUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomProfileAvatar(
              name: loggedInUser?.name ?? 'User',
              radius: 50,
            ),
          ),
          Text(
            "Welcome ${loggedInUser?.name ?? 'User'}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contact List- ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60,
                  ),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const UserContactList(),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: LogoutButton(),
          ),
        ],
      ),
    );
  }
}
