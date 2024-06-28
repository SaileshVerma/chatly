import 'dart:convert';
import 'package:chatly/screens/chat_screen/widgets/app_bar_title_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

import 'package:chatly/repositories/contacts_repository.dart';
import 'package:chatly/bloc/contacts/contact_bloc.dart';
import 'package:chatly/bloc/contacts/contact_event.dart';
import 'package:chatly/bloc/contacts/contact_state.dart';
import 'package:chatly/screens/chat_screen/add_contact_widgets/add_contact_form.dart';
import 'package:chatly/screens/chat_screen/widgets/contacts_drawer.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/models/user.dart';
import 'package:chatly/repositories/user_repository.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> msgs = [];

  final TextEditingController _controller = TextEditingController();

  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.org/.sse'),
  );

  User? loggedInUser;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await HiveService().getLoggedInUser();
      setState(() {
        loggedInUser = user;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = Message(
        content: _controller.text,
        timestamp: DateTime.now(),
      );

      _channel.sink.add(
        json.encode(message.toJson()),
      );

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        backgroundColor: Colors.green,
        title: const AppBarTitleWidget(),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddContactForm();
                  },
                );
              },
              icon: const Icon(Icons.person_add)),
          // const LogoutButton(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    snapshot.data.toString().contains('Request')
                        ? null
                        : msgs.add(
                            Message.fromJson(json: json.decode(snapshot.data)));

                    return ListView.builder(
                        itemCount: msgs.length,
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            title: Text(msgs[i].content ?? ""),
                          );
                        });
                  } else {
                    return Center(child: Text('No messages yet.'));
                  }
                },
              ),
            ),
            Row(
              children: [
                Text("${loggedInUser?.name ?? "@@@@@@@@"}"),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Send a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    ContactsRepositoryHiveService()
                        .getCurrentLoggedInUserContacts(
                            currentUserNumber: loggedInUser?.number ?? '');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: const ChatDrawer(),
    );
  }
}

class DrawerMenuButton extends StatelessWidget {
  const DrawerMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (ctx, state) => IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          ctx.read<ContactBloc>().add(const GetCurrentUserContactList());
          scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
  }
}
