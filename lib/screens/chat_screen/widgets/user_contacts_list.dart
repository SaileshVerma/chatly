import 'package:flutter/material.dart';

class UserContactList extends StatelessWidget {
  const UserContactList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (ctx, i) {
        return const Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text("freind 1"),
              subtitle: Text("Messages"),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}

enum Communicator { sender, receiver }
